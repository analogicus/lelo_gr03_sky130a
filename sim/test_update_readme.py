"""Tests for update_readme.py — FSM extraction, parameter extraction, section replacement."""

from __future__ import annotations

from pathlib import Path

import pytest

from update_readme import extract_fsm, extract_params, fsm_to_mermaid, replace_section

SV_TEXT = """\
typedef enum logic [1:0] {
    IDLE    = 2'b00
    , COUNT   = 2'b01
    , WAIT    = 2'b11
    , CAPTURE = 2'b10
  } state_t;

  always_comb begin
    case (cur_state)
      IDLE:
        if (i_start) next_state = COUNT;
        else next_state = IDLE;
      COUNT:   next_state = WAIT;
      WAIT:    next_state = CAPTURE;
      CAPTURE: next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end
"""


class TestExtractFsm:
    def test_states(self) -> None:
        states = extract_fsm(SV_TEXT)[0]
        assert set(states) == {"IDLE", "COUNT", "WAIT", "CAPTURE"}

    def test_transitions(self) -> None:
        transitions = extract_fsm(SV_TEXT)[1]
        assert ("IDLE", "COUNT", "i_start") in transitions
        assert ("COUNT", "WAIT", "") in transitions
        assert ("WAIT", "CAPTURE", "") in transitions
        assert ("CAPTURE", "IDLE", "") in transitions

    def test_no_self_loops(self) -> None:
        transitions = extract_fsm(SV_TEXT)[1]
        for src, dst, _ in transitions:
            assert src != dst, f"Self-loop found: {src} -> {dst}"

    def test_mermaid_output(self) -> None:
        states, transitions = extract_fsm(SV_TEXT)
        mermaid = fsm_to_mermaid(states, transitions)
        assert "stateDiagram-v2" in mermaid
        assert "[*] --> IDLE" in mermaid
        assert "IDLE --> COUNT : i_start" in mermaid
        assert "COUNT --> WAIT" in mermaid


ROOT = Path(__file__).resolve().parent.parent


class TestExtractParams:
    def test_returns_expected_keys(self) -> None:
        params = extract_params(ROOT)
        expected_keys = {"freq", "ileak", "iact", "iavg", "kerr1", "kerr2"}
        assert expected_keys <= set(params.keys())

    def test_freq_range(self) -> None:
        params = extract_params(ROOT)
        assert 1.0 < params["freq"] < 10.0, f"Freq out of range: {params['freq']}"

    def test_ileak_range(self) -> None:
        params = extract_params(ROOT)
        assert 0.0 <= params["ileak"] < 100.0, f"Ileak out of range: {params['ileak']}"

    def test_iact_range(self) -> None:
        params = extract_params(ROOT)
        assert 1.0 < params["iact"] < 200.0, f"Iact out of range: {params['iact']}"

    def test_iavg_range(self) -> None:
        params = extract_params(ROOT)
        assert 0.0 < params["iavg"] < 100.0, f"Iavg out of range: {params['iavg']}"

    def test_kerr_positive(self) -> None:
        params = extract_params(ROOT)
        assert params["kerr1"] > 0, "Kerr1 should be positive"
        assert params["kerr2"] > 0, "Kerr2 should be positive"

    def test_kerr2_less_than_kerr1(self) -> None:
        params = extract_params(ROOT)
        assert params["kerr2"] < params["kerr1"], "2-pt should be better than 1-pt"


class TestReplaceSection:
    def test_basic_replacement(self) -> None:
        text = "before\n<!-- AUTO:FOO -->\nold content\n<!-- /AUTO:FOO -->\nafter"
        result = replace_section(text, "FOO", "new content\n")
        assert "new content" in result
        assert "old content" not in result
        assert "before" in result
        assert "after" in result

    def test_markers_preserved(self) -> None:
        text = "<!-- AUTO:BAR -->\nstuff\n<!-- /AUTO:BAR -->"
        result = replace_section(text, "BAR", "replaced\n")
        assert result.startswith("<!-- AUTO:BAR -->")
        assert result.endswith("<!-- /AUTO:BAR -->")

    def test_no_marker_raises(self) -> None:
        text = "no markers here"
        with pytest.raises(ValueError, match="BAZ"):
            replace_section(text, "BAZ", "anything")
