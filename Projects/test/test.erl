-module(test).
-export([a/2, b/2, c/1, d/1, e/1, f/1, g/1, h/1, i/1, j/1, k/2, l/2, m/3, n/3, o/1, r/1, t/1, v/2]).

a(P, L) -> a(P, L, 0).
a(P, [H|T], PO) -> case P =:= H of
				true -> [{PO, P} | a(P, T, PO+1)];
				false -> a(P, T, PO+1)
				end;
a(_P, [], _PO) -> [].
b(P, [H|T]) -> case P =:= H of
				true -> b(P, T);
				false -> [H|b(P, T)]
				end;
b(_P, []) -> [].
c([H|T]) -> c(T, H);
c([]) -> [].
c([H|T], LAST) -> if
				LAST > H -> c(T, LAST);
				LAST < H -> c(T, H);
				LAST =:= H -> c(T, LAST)
				end;
c([], LAST) -> LAST.
d(L) -> if
	length(L) > 0 -> d(L, c(L));
	true -> []
	end.
d(L, MAX) -> [MAX|d(b(MAX, L))].
e(L) -> lists:reverse(d(L)).
f(L) -> if
	length(L) > 0 -> f(L, c(L));
	true -> []
	end.
f([H|T], PATTERN) -> case H =:= PATTERN of
					true -> T;
					false -> [H|f(T, PATTERN)]
					end;
f([], _PATTERN) -> [].
g(L) -> if
	length(L) > 0 -> g(L, c(L));
	true -> []
	end.
g(L, MAX) -> [MAX|g(f(L, MAX))].
h(L) -> lists:reverse(g(L)).
i(0) -> 1;
i(1) -> 1;
i(M) -> M * i(M-1).
j(0) -> 1;
j(M) -> if
		M > 0 -> 2 * j(M-1);
		M < 0 -> 1 / j(M*-1)
		end.
k([], _POS) -> [];
k([H|_T], 0) -> H;
k([_H|T], POS) -> k(T, POS-1).
l(_B, 0) -> 1;
l(B, 1) -> B;
l(B, E) -> B * l(B, E-1).
m(B, E, Name) -> file:write_file(Name, io_lib:format("~p \r", [l(B, E)])).
n(B, E, Name) -> case file:read_file_info(Name) of
        				{ok, _FileInfo} ->
                 			file:write_file(Name, io_lib:format("~p \r", [l(B, E)]), [append]);
        				{error, enoent} ->
											m(B, E, Name)
 								end.
o(0) -> p(0),s('hello.3');
o(C) -> p(C),
				o(C-1).
p(E) -> n(2, E, 'hello.3').
q(E) -> n(2, E, 'hello.4').
r(0, C) -> q(C),s('hello.4');
r(N, C) -> q(C),
						r(N-1, C+1).
r(N) -> r(N, 0).
s(Name) -> file:write_file(Name, io_lib:format("\r", []), [append]).
t(C) -> file:write_file("hello.5", io_lib:format("~p.~n \r", [os:timestamp()]), [append]),
				u(C, "hello.5"),
				file:write_file("hello.5", io_lib:format("~p.~n \r\r\r", [os:timestamp()]), [append]).
u(C, Name) -> n(2, C, Name).
v(C, Name) -> file:write_file(Name , io_lib:format("~p.~n \r\r", [timer:tc(test, n, [2, C, Name])]), [append]).
