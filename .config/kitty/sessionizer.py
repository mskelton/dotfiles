import os
from kitty.boss import Boss
from kittens.tui.handler import result_handler


def main(args: list[str]) -> str:
    pass


@result_handler(no_ui=True)
def handle_result(
    args: list[str],
    answer: str,
    target_window_id: int,
    boss: Boss,
) -> None:
    # Get list of directories in ~/dev/
    dev_dir = os.path.expanduser("~/dev")
    try:
        dirs = sorted(
            [d for d in os.listdir(dev_dir) if os.path.isdir(os.path.join(dev_dir, d))]
        )
    except OSError:
        return

    if not dirs:
        return

    # Show a selection dialog using kitty's built-in chooser
    boss.choose(
        # "Select a project directory:",
        # lambda selected: launch_session(selected, dev_dir, boss),
        # *dirs,
        "Select a project directory:",
        lambda selected: launch_session(selected, dev_dir, boss),
        "o:Open",
        "c:Copy to clipboard",
        "n;red:Nothing",
        default="o",
        # window=self,
        # title=_("Hyperlink activated"),
    )


def launch_session(directory: str, dev_dir: str, boss: Boss) -> None:
    if directory:
        # Construct the full path relative to ~/dev/
        full_path = os.path.join(dev_dir, directory)

        # Launch a new tab window with the selected directory
        boss.launch(
            "--type=tab",
            "--tab-title=" + directory,
            "--cwd=" + full_path,
        )
