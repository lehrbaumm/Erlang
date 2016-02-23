-module(test).
-export([a/2, b/2, c/1, d/1, e/1, f/1, g/1, h/1, i/1, j/1, k/2]).

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