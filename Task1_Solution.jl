using Yao, YaoPlots

function answer(x)
	y = reverse.(digits.(x, base=2, pad = Int(ceil(log(2,maximum(x)+1)))))
	n_address = Int(ceil(log(2,length(y))))
	n_arr = length(y[1])
	n = n_address+n_arr+1
	
	address = digits.(0:2^n_address-1, base=2, pad = n_address)
	rep = reverse([findall(isone, address[i]) for i in 1:length(y)])
	
	f(x) = chain(n, [control(1:n_address, (k+n_address)=>X) for k in findall(isone, x)])
	QRAM = chain([chain(repeat(X, rep[i]), f(y[i]), repeat(X, rep[i])) for i in 1:length(y)-1])
	QRAM = chain(QRAM, f(y[end]))
		
	U𝜑(n) = chain(n, repeat(H, 1:n), repeat(X, 1:n), control(1:n-1, n=>Z), repeat(X, 1:n), repeat(H, 1:n))

	checker_1 = chain(n_arr + 1, 
		repeat(X, 1:2:n_arr), 
		control(1:n_arr, (n_arr+1)=>Z), 
		repeat(X, 1:2:n_arr))
	
	checker_2 = chain(n_arr + 1, 
		repeat(X, 2:2:n_arr), 
		control(1:n_arr, (n_arr + 1) => Z), 
		repeat(X, 2:2:n_arr))

	circuit = chain(n, repeat(H, 1:n_address), put(n=>H),
	QRAM, 
	put(n_address+1 : n => checker_1), 
	put(n_address+1 : n => checker_2),
	QRAM',
	put(collect(Iterators.flatten((1:n_address, n))) => U𝜑(n_address+1)))
	
	return circuit
end
