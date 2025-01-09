import subprocess
from kitty.boss import Boss
from kittens.tui.handler import result_handler

def main(args: list[str]) -> str:
    pass

@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    tmux = "/opt/homebrew/bin/tmux"
    sessions = subprocess.run([tmux, *args[1:]])
