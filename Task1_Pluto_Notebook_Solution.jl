### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ 9ea9660f-e799-4abf-9a95-56e344a5208f
using Yao, YaoPlots

# ╔═╡ b6fa6388-6b69-493c-9314-b29eced3e3f4
x = [5,7,1,10]

# ╔═╡ f2a2c511-1645-4ae0-acfc-8d2f5f184cde
y = reverse.(digits.(x, base=2, pad = Int(ceil(log(2,maximum(x)+1)))))

# ╔═╡ 8b50c80d-1380-4a25-9774-e417eb790d9a
begin
	n = length(y)
	
	f(x) = chain(7, [control(1:2, (k+2)=>X) for k in findall(isone, x)])
	QRAM = chain(7, repeat(H, 1:2), 
		repeat(X, 1:2), f(y[1]), 
		repeat(X, 1:2), put(1=>X), f(y[2]), 
		put(1=>X), put(2=>X), f(y[3]), 
		put(2=>X), f(y[4]))
	
	plot(QRAM)
end

# ╔═╡ e5a2456b-3e26-405c-80ea-d1ad85d12e5a
begin
	U𝜑 = chain(2, repeat(H, 1:2), repeat(X, 1:2), put(2=>H), control(2, 1=>X), put(2=>H), repeat(X, 1:2), repeat(H, 1:2))
	
	plot(U𝜑)
end

# ╔═╡ 3f61117a-135e-433c-879a-00ba96b923e4
begin
	checker_1 = chain(5, repeat(X, 1:2:4), control(1:4, 5=>Z), repeat(X, 1:2:4))
	plot(checker_1)
end

# ╔═╡ 3d2c152e-47d8-4a35-a6fc-44863a86cd32
begin
	checker_2 = chain(5, repeat(X, 2:2:4), control(1:4, 5=>Z), repeat(X, 2:2:4))
	plot(checker_2)
end

# ╔═╡ 7ec3e06a-5d92-48b7-8501-eb71aa1c20ef
circuit = chain(7, put(7=>H), put(7=>X), QRAM, put(3:7=>checker_1), put(3:7=>checker_2), QRAM', put(1:2=>U𝜑)); plot(circuit)

# ╔═╡ e4bc5c27-971f-4150-a192-f725b673e543
output = zero_state(7) |> circuit

# ╔═╡ a185e144-1b95-4cd4-8437-33461c0352ef
state(partial_tr(output, 3:7)) #traces out the 3rd to 7th qubits

# ╔═╡ 6422d347-1ee1-4649-a746-272edb03efe9
output |> r->measure(r, nshots=1024, 1:2)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Yao = "5872b779-8223-5990-8dd0-5abbb0748c8c"
YaoPlots = "32cfe2d9-419e-45f2-8191-2267705d8dbc"

[compat]
Yao = "~0.6.4"
YaoPlots = "~0.6.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0-beta4"
manifest_format = "2.0"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "f87e559f87a45bece9c9ed97458d3afe98b1ebb9"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.1.0"

[[deps.ArrayInterface]]
deps = ["IfElse", "LinearAlgebra", "Requires", "SparseArrays", "Static"]
git-tree-sha1 = "d84c956c4c0548b4caf0e4e96cf5b6494b5b1529"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "3.1.32"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitBasis]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "8da3743b92ca88c738fd509c02679d856f7ee141"
uuid = "50ba71b6-fa0f-514d-ae9a-0916efc90dcf"
version = "0.7.2"

[[deps.CacheServers]]
deps = ["Distributed", "Test"]
git-tree-sha1 = "b584b04f236d3677b4334fab095796a128445bf8"
uuid = "a921213e-d44a-5460-ac04-5d720a99ba71"
version = "0.2.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "32a2b8af383f11cbb65803883837a149d10dfe8a"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.10.12"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "4866e381721b30fac8dda4c8cb1d9db45c8d2994"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.37.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Compose]]
deps = ["Base64", "Colors", "DataStructures", "Dates", "IterTools", "JSON", "LinearAlgebra", "Measures", "Printf", "Random", "Requires", "Statistics", "UUIDs"]
git-tree-sha1 = "c6461fc7c35a4bb8d00905df7adafcff1fe3a6bc"
uuid = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
version = "0.9.2"

[[deps.DataAPI]]
git-tree-sha1 = "bec2532f8adb82005476c141ec23e921fc20971b"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.8.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Dierckx]]
deps = ["Dierckx_jll"]
git-tree-sha1 = "5fefbe52e9a6e55b8f87cb89352d469bd3a3a090"
uuid = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
version = "0.5.1"

[[deps.Dierckx_jll]]
deps = ["CompilerSupportLibraries_jll", "Libdl", "Pkg"]
git-tree-sha1 = "a580560f526f6fc6973e8bad2b036514a4e3b013"
uuid = "cd4c43a9-7502-52ba-aa6d-59fb2a88580b"
version = "0.0.1+0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.ExponentialUtilities]]
deps = ["ArrayInterface", "LinearAlgebra", "Printf", "Requires", "SparseArrays"]
git-tree-sha1 = "7a541ee92e2f8b16356ed6066d0c44b85984b780"
uuid = "d4d017d3-3776-5f7e-afef-a10c40355c18"
version = "1.9.0"

[[deps.Expronicon]]
deps = ["MLStyle", "Pkg", "TOML"]
git-tree-sha1 = "514f1ab747af4341095781d18df9f738408918d6"
uuid = "6b7a57c9-7cc1-4fdf-b7f5-e857abae3636"
version = "0.6.9"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.GraphPlot]]
deps = ["ArnoldiMethod", "ColorTypes", "Colors", "Compose", "DelimitedFiles", "LightGraphs", "LinearAlgebra", "Random", "SparseArrays"]
git-tree-sha1 = "dd8f15128a91b0079dfe3f4a4a1e190e54ac7164"
uuid = "a2cc645c-3eea-5389-862e-a155d0052231"
version = "0.4.4"

[[deps.IfElse]]
git-tree-sha1 = "28e837ff3e7a6c3cdb252ce49fb412c8eb3caeef"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.0"

[[deps.Inflate]]
git-tree-sha1 = "f5fc07d4e706b84f72d54eedcc1c13d92fb0871c"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.LegibleLambdas]]
deps = ["MacroTools"]
git-tree-sha1 = "7946db4829eb8de47c399f92c19790f9cc0bbd07"
uuid = "f1f30506-32fe-5131-bd72-7c197988f9e5"
version = "0.3.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LightGraphs]]
deps = ["ArnoldiMethod", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "432428df5f360964040ed60418dd5601ecd240b6"
uuid = "093fc24a-ae57-5d10-9952-331d41423f4d"
version = "1.3.5"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LuxurySparse]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "StaticArrays"]
git-tree-sha1 = "304f50d6b663224d2ca81ce93b317c35ed2d39da"
uuid = "d05aeea4-b7d4-55ac-b691-9e7fabb07ba2"
version = "0.6.7"

[[deps.MLStyle]]
git-tree-sha1 = "594e189325f66e23a8818e5beb11c43bb0141bcd"
uuid = "d8e11817-5142-5d16-987a-aa16d5891078"
version = "0.4.10"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "5a5bc6bf062f0f95e62d0fe0a2d99699fed82dd9"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.8"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.Multigraphs]]
deps = ["LightGraphs", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "2fb7159113eeded54437f8abeab72bb994299bda"
uuid = "7ebac608-6c66-46e6-9856-b5f43e107bac"
version = "0.2.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "438d35d2d95ae2c5e8780b330592b6de8494e779"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Static]]
deps = ["IfElse"]
git-tree-sha1 = "a8f30abc7c64a39d389680b74e749cf33f872a70"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.3.3"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3240808c6d463ac46f1c1cd7638375cd22abbccb"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.12"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8cbbc098554648c84f79a463c9ff0fd277144b6c"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.10"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TupleTools]]
git-tree-sha1 = "3c712976c47707ff893cf6ba4354aa14db1d8938"
uuid = "9d95972d-f1c8-5527-a6e0-b4b365fa01f6"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Viznet]]
deps = ["Compose", "Dierckx"]
git-tree-sha1 = "7a022ae6ac8b153d47617ed8c196ce60645689f1"
uuid = "52a3aca4-6234-47fd-b74a-806bdf78ede9"
version = "0.3.3"

[[deps.Yao]]
deps = ["BitBasis", "Reexport", "YaoArrayRegister", "YaoBase", "YaoBlocks", "YaoSym"]
git-tree-sha1 = "21e49c3b1f3ec891fd728664feae600c8601b013"
uuid = "5872b779-8223-5990-8dd0-5abbb0748c8c"
version = "0.6.4"

[[deps.YaoAPI]]
git-tree-sha1 = "dc4edfcda2e59fd2624f84941da040a4e30220e3"
uuid = "0843a435-28de-4971-9e8b-a9641b2983a8"
version = "0.1.0"

[[deps.YaoArrayRegister]]
deps = ["Adapt", "BitBasis", "LinearAlgebra", "LuxurySparse", "Random", "StaticArrays", "StatsBase", "TupleTools", "YaoBase"]
git-tree-sha1 = "da1a1fb273d5605c7dddc5e63850ec25f3cf9b67"
uuid = "e600142f-9330-5003-8abb-0ebd767abc51"
version = "0.7.8"

[[deps.YaoBase]]
deps = ["BitBasis", "LegibleLambdas", "LinearAlgebra", "LuxurySparse", "MLStyle", "Random", "Reexport", "SparseArrays", "TupleTools", "YaoAPI"]
git-tree-sha1 = "2048ba99289732ee5c2fb279d19a60cca2345ce6"
uuid = "a8f54c17-34bc-5a9d-b050-f522fe3f755f"
version = "0.14.4"

[[deps.YaoBlocks]]
deps = ["BitBasis", "CacheServers", "ExponentialUtilities", "InteractiveUtils", "LegibleLambdas", "LinearAlgebra", "LuxurySparse", "MLStyle", "Random", "SimpleTraits", "SparseArrays", "StaticArrays", "StatsBase", "TupleTools", "YaoArrayRegister", "YaoBase"]
git-tree-sha1 = "dd9fc50384876eb2194bcabc726d96b8995a4ac1"
uuid = "418bc28f-b43b-5e0b-a6e7-61bbc1a2c1df"
version = "0.11.6"

[[deps.YaoHIR]]
deps = ["Expronicon", "MLStyle", "YaoLocations"]
git-tree-sha1 = "938fb1436c702dddbbfb2bf173f28e8ebbc48ee0"
uuid = "6769671a-fce8-4286-b3f7-6099e1b1298a"
version = "0.2.0"

[[deps.YaoLocations]]
git-tree-sha1 = "c90c42c8668c9096deb0c861822f0f8f80cbdc68"
uuid = "66df03fb-d475-48f7-b449-3d9064bf085b"
version = "0.1.6"

[[deps.YaoPlots]]
deps = ["BitBasis", "Colors", "Compose", "GraphPlot", "LightGraphs", "Multigraphs", "Viznet", "YaoBlocks", "ZXCalculus"]
git-tree-sha1 = "4ddc139fadcfb14ca417f794f8172e4aba3e6d3a"
uuid = "32cfe2d9-419e-45f2-8191-2267705d8dbc"
version = "0.6.1"

[[deps.YaoSym]]
deps = ["BitBasis", "LinearAlgebra", "LuxurySparse", "Requires", "SparseArrays", "YaoArrayRegister", "YaoBase", "YaoBlocks"]
git-tree-sha1 = "e34838fa98d02d4c969ba9f92783a12a336e2f88"
uuid = "3b27209a-d3d6-11e9-3c0f-41eb92b2cb9d"
version = "0.4.7"

[[deps.ZXCalculus]]
deps = ["LightGraphs", "LinearAlgebra", "MLStyle", "Multigraphs", "SparseArrays", "YaoHIR", "YaoLocations"]
git-tree-sha1 = "2c8e639422053cbdb7bf515fcb754372c752829b"
uuid = "3525faa3-032d-4235-a8d4-8c2939a218dd"
version = "0.4.4"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═9ea9660f-e799-4abf-9a95-56e344a5208f
# ╠═b6fa6388-6b69-493c-9314-b29eced3e3f4
# ╠═f2a2c511-1645-4ae0-acfc-8d2f5f184cde
# ╠═8b50c80d-1380-4a25-9774-e417eb790d9a
# ╠═e5a2456b-3e26-405c-80ea-d1ad85d12e5a
# ╠═3f61117a-135e-433c-879a-00ba96b923e4
# ╠═3d2c152e-47d8-4a35-a6fc-44863a86cd32
# ╠═7ec3e06a-5d92-48b7-8501-eb71aa1c20ef
# ╠═e4bc5c27-971f-4150-a192-f725b673e543
# ╠═a185e144-1b95-4cd4-8437-33461c0352ef
# ╠═6422d347-1ee1-4649-a746-272edb03efe9
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
