Phoenix.set({
  daemon: true,
  openAtLogin: true,
})

function split(leftWindows, rightWindows) {
  const screen = Screen.main().flippedVisibleFrame()
  const width = screen.width * 0.5
  const args = {
    y: screen.y,
    width: width,
    height: screen.height,
  }

  leftWindows.forEach((window) => {
    window.setFrame({ ...args, x: screen.x })
  })

  rightWindows.forEach((window) => {
    window.setFrame({ ...args, x: screen.x + width })
  })
}

// Main layout, browser on right most screen, Figma behind browser, Kitty on
// main screen. Email/Slack on left most screen.
Key.on("u", ["cmd", "option"], () => {
  const arc = App.get("Arc")
  const kitty = App.get("kitty")
  const figma = App.get("Figma")
  const slack = App.get("Slack")
  const mimestream = App.get("Mimestream")
})

// Split layout, browser on left of main screen, Kitty on right of main screen.
// Figma maximized on the right most screen, Email/Slack on left most screen.
Key.on("i", ["cmd", "control"], () => {
  const arc = App.get("Arc")
  const kitty = App.get("kitty")
  const figma = App.get("Figma")
  const slack = App.get("Slack")
  const mimestream = App.get("Mimestream")
})

// Maximize everything
Key.on("o", ["cmd", "control"], () => {
  App.all().forEach((app) => {
    app.windows().forEach((window) => {
      window.maximise()
    })
  })
})
