Phoenix.set({
  daemon: true,
  openAtLogin: true,
})

function split(screen, leftWindows, rightWindows) {
  const width = screen.width * 0.5
  const args = {
    y: screen.y,
    width: width,
    height: screen.height,
  }

  leftWindows?.forEach((win) => win.setFrame({ ...args, x: screen.x }))
  rightWindows?.forEach((win) => win.setFrame({ ...args, x: screen.x + width }))
}

function maximize(screen, ...windows) {
  windows.forEach((win) => win?.setFrame(screen))
}

// Main layout, browser on right most screen, Figma behind browser, Kitty on
// main screen. Email/Slack on left most screen.
Key.on("u", ["cmd", "control"], () => {
  const arc = App.get("Arc")
  const kitty = App.get("kitty")
  const figma = App.get("Figma")
  const slack = App.get("Slack")
  const mimestream = App.get("Mimestream")

  const screens = Screen.all()
    .map((screen) => screen.flippedVisibleFrame())
    .toSorted((a, b) => a.x - b.x)

  if (screens.length === 3) {
    maximize(screens[0], ...mimestream?.windows(), ...slack?.windows())
    maximize(screens[1], ...kitty?.windows())
    maximize(screens[2], ...figma.windows(), ...arc?.windows())
  }
})

// Split layout, browser on left of main screen, Kitty on right of main screen.
// Figma maximized on the right most screen, Email/Slack on left most screen.
Key.on("i", ["cmd", "control"], () => {
  const arc = App.get("Arc")
  const kitty = App.get("kitty")
  const figma = App.get("Figma")
  const slack = App.get("Slack")
  const mimestream = App.get("Mimestream")

  const screens = Screen.all()
    .map((screen) => screen.flippedVisibleFrame())
    .toSorted((a, b) => a.x - b.x)

  if (screens.length === 3) {
    maximize(screens[0], ...mimestream?.windows(), ...slack?.windows())
    split(screens[1], arc?.windows(), kitty?.windows())
    maximize(screens[2], ...figma?.windows())
  }
})

// Maximize everything
Key.on("o", ["cmd", "control"], () => {
  const ignored = new Set(["Chatter", "zoom.us"])

  Window.all()
    .filter((win) => !ignored.has(win.app().name()))
    .forEach((win) => win.maximize())
})
