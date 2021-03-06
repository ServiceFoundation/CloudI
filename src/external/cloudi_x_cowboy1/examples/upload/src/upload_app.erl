%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(upload_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.
start(_Type, _Args) ->
	Dispatch = cowboy1_router:compile([
		{'_', [
			{"/", cowboy1_static, {priv_file, upload, "index.html"}},
			{"/upload", upload_handler, []},
			{"/files/[...]", cowboy1_static, {priv_dir, upload, "files"}}
		]}
	]),
	{ok, _} = cowboy1:start_http(http, 100, [{port, 8080}],
		[{env, [{dispatch, Dispatch}]}]),
	upload_sup:start_link().

stop(_State) ->
	ok.
