import os
from kitty.boss import Boss


def main(args: list[str]) -> str | None:
    try:
        directory = input("Select a directory: ")
        return directory
    except KeyboardInterrupt:
        return None


def handle_result(
    args: list[str],
    answer: str,
    target_window_id: int,
    boss: Boss,
) -> None:
    if answer:
        # Construct the full path relative to ~/dev/
        dev_dir = os.path.expanduser("~/dev")
        full_path = os.path.join(dev_dir, answer)

        # Launch a new tab window with the selected directory
        boss.launch(
            "--type=tab",
            "--tab-title=" + answer,
            "--cwd=" + full_path,
        )
