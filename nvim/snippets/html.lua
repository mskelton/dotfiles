---@diagnostic disable: undefined-global

local html = [[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Document</title>
</head>
<body>
    $0
</body>
</html>
]]

return {
	parse("html", html),
}
