-module(afile_server).
-export([start/1, loop/1]).

start(Dir) ->
       spawn(afile_server, loop, [Dir]).

loop(Dir) ->
	receive % What to do when receiving a message
		{Client, list_dir} -> %List directory
			Client ! {self(), file:list_dir(Dir)};
		{Client, {get_file, File}} -> % or show file
			Full = filename:join(Dir, File),
			Client ! {self(), file:read_file(Full)}
	end,
	loop(Dir). % restart loop
