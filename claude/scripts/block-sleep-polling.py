#!/usr/bin/env python3
"""
PreToolUse hook for the Bash tool: block waiting/polling patterns
(sleep N, until ... done, while ... sleep). The user has repeatedly
asked Claude not to use these. Exit 2 + stderr message tells Claude
to use Bash run_in_background:true and tool-completion notifications.
"""
import json
import re
import sys

PATTERN = re.compile(r"\bsleep\s+\d|\buntil\s+|while\s+.*sleep")

try:
    data = json.load(sys.stdin)
    cmd = data.get("tool_input", {}).get("command", "")
except Exception:
    sys.exit(0)

if PATTERN.search(cmd):
    sys.stderr.write(
        "Blocked: do not use `sleep N`, `until ... done`, or `while ... sleep` "
        "for waiting. These waste time and burn tokens polling.\n"
        "Instead: invoke Bash with run_in_background:true and rely on the "
        "tool-completion notification, or run the foreground command and let "
        "it block naturally. To wait on a process you started in the "
        "background, just continue with other work — you'll be notified when "
        "it finishes.\n"
    )
    sys.exit(2)
