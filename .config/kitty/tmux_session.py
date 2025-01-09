import subprocess
from kitty.boss import Boss
from kittens.tui.handler import result_handler

def main(args: list[str]) -> str:
    pass

@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    index = int(args[1])
    tmux = "/opt/homebrew/bin/tmux"

    # Get all Tmux sessions
    sessions = subprocess.check_output(
        [tmux, "list-sessions", "-F", "#{session_created} #{session_name}"],
        text=True
    ).strip().split("\n")

    # Sort the sessions by creation time
    sorted_sessions = sorted(sessions, key=lambda x: int(x.split(" ")[0]))
    session_names = [session.split(" ", 1)[1] for session in sorted_sessions]

    # If the requested session does not exist, do nothing
    if index >= len(session_names):
        return

    # Switch to the requested session
    subprocess.run([tmux, "switch-client", "-t", session_names[index]])

