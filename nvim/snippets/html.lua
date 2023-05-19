---@diagnostic disable: undefined-global

local html = [[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <title>Document</title>
    <meta name="description" content="Description" />
</head>
<body>
    $0
</body>
</html>
]]

return {
	parse("html", html),
}
