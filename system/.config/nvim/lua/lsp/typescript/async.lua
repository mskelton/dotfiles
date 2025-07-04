local M = {}

--- Execute a function asynchronously
--- @param func function
--- @param res function
--- @param rej function
function M.exec(func, res, rej)
	local thread = coroutine.create(func)
	local step
	step = function(...)
		local args = { ... }
		local ok, nxt = coroutine.resume(thread, unpack(args))
		if coroutine.status(thread) ~= "dead" then
			local _, err = xpcall(nxt, debug.traceback, step)
			if err then
				rej(err)
			end
		elseif ok then
			res(unpack(args))
		else
			rej(debug.traceback(thread, nxt))
		end
	end

	step()
end

function M.call(func, ...)
	local args = { ... }
	return coroutine.yield(function(cb)
		table.insert(args, cb)
		func(unpack(args))
	end)
end

function M.async_call_err(func, ...)
	local args = { ... }
	return coroutine.yield(function(cb)
		table.insert(args, cb)
		table.insert(args, function(e)
			error(e)
		end)
		func(unpack(args))
	end)
end

function M.schedule()
	return coroutine.yield(function(cb)
		vim.schedule(cb)
	end)
end

function M.request(client, method, params, bufnr)
	return coroutine.yield(function(cb)
		client.request(method, params, cb, bufnr)
	end)
end

return M
