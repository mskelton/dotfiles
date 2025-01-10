import subprocess
from kitty.boss import Boss
from kittens.tui.handler import result_handler

def main(args: list[str]) -> str:
    pass

@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    inc = int(args[1])

    # Get all Tmux sessions
    sessions = tmux(["list-sessions", "-F", "#{session_created} #{session_name}"])
    sessions = sorted(sessions, key=lambda x: int(x.split(' ')[0]))
    sessions = [x.split(' ')[1] for x in sessions]

    # Get current session
    current_session = tmux(["display-message", "-p", "#{session_name}"])[0]

    # Get the total number of sessions
    total_sessions=len(sessions)

    # Get the current session index
    current_index = sessions.index(current_session)

    # Get the next session index based on the direction, loop around if necessary
    next_index = (current_index + inc) % total_sessions

    # Switch to the requested session
    tmux(["switch-client", "-t", sessions[next_index]])

def tmux(args: list[str]) -> list[str]:
    cmd = ["/opt/homebrew/bin/tmux"] + args
    return subprocess.check_output(cmd, text=True).strip().split("\n")

