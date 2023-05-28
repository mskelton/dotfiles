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

// Split browser and terminal
Key.on("k", ["cmd", "option"], () => {
  const arc = App.get("Arc")
  const kitty = App.get("kitty")

  split(arc ? arc.windows() : [], kitty ? kitty.windows() : [])
})

// Maximize everything
Key.on("l", ["cmd", "option"], () => {
  App.all().forEach((app) => {
    app.windows().forEach((window) => {
      window.maximise()
    })
  })
})
