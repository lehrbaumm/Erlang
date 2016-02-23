-module(fib).
-export([fibo/1, fibo/2, fibo/3]).

fibo(0) -> [];
%fibo(N) -> [ {H, fibo(H, 1)} || H <- [1|fibo(N-1, 2, 1)]].
fibo(N) -> [1|fibo(N-1, 2, 1)].
fibo(0, 1) -> [];
fibo(N, 1) -> [1|fibo(N-1, 2, 1)].
fibo(0, J, I) ->  [I];
fibo(N, J, I) ->  [I|fibo(N-1, J+I, J)].