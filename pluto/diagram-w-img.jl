### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 36927b11-2363-4d84-89a3-77cb4a63939a
# ╠═╡ show_logs = false
begin
	using Pkg
	Pkg.add("Luxor")
	using Luxor
	Pkg.add("Colors")
	using Colors
	Pkg.add("FileIO")
	using FileIO
	Pkg.add("Images")
	using Images
	Pkg.add("Downloads")
	using Downloads
	Pkg.add("PlutoUI")
	using PlutoUI


	
	Pkg.add("HmtArchive")
	using HmtArchive.Analysis
	Pkg.add("CitableObject")
	using CitableObject
	Pkg.add("CitableText")
	using CitableText
	Pkg.add("CitablePhysicalText")
	using CitablePhysicalText
	Pkg.add("CitableImage")
	using CitableImage

	Pkg.add(url = "https://github.com/dwryan25/MSPageLayout.jl")
	using MSPageLayout

	Pkg.update()

	Pkg.status()
end

# ╔═╡ d2424f38-d821-44b6-8fd9-365ee695f324
md"*The following hidden cell sets up the Julia environment.*"

# ╔═╡ 874b7016-1e70-11ee-06bd-6dffcdd850d4
md"""# Diagram page layout"""

# ╔═╡ 0e71905f-081e-4615-bee8-247ee9cbfa2e
md"""*Width of image (pixels)* $(@bind w confirm(Slider(200:50:800, show_value=true)))"""

# ╔═╡ 34409b3f-cb5c-409c-bebf-03befe1b6492
md"""*Set image transparency* $(@bind alpha Slider(0:0.1:1.0, show_value=true, 
default=0.5))"""

# ╔═╡ dcce74ec-4d0c-4017-bcc5-58a6e07dbfe4
html"""
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
"""

# ╔═╡ 36973a8c-a31e-4d93-a61d-6906786ec079
md"> **Framing the diagram**"

# ╔═╡ 30f78169-805d-4c38-89c4-115ca7e4f3e7
padding = 5

# ╔═╡ 6302db98-daf9-480d-bdda-2e350245a1bc
wpad = w + 2 * padding

# ╔═╡ 65ace1d4-eb73-4924-875c-d24798f6b8cd
h = 1.5 * w

# ╔═╡ b405679c-ec6a-40e6-b8f5-44889233db9d
hpad = h + 2 * padding

# ╔═╡ 8ca6b28d-fb26-475b-9a1d-f8091c246037
"""Draw gray frame around page borders. Width and height
of page should be given in current coordinate system of diagram.
"""
function framepage(wdth, ht)
	sethue("gray30")
	line(O, Point(wdth,0))
	line(Point(wdth,0), Point(wdth, ht))
	line(Point(wdth, ht), Point(0,ht))
	line(Point(0,ht), O)
end

# ╔═╡ df5ff74c-435c-43ad-9e70-d23418b28721
scholia_left = .7 * w

# ╔═╡ 9e630977-1097-499f-bb7c-a79fb4e5cfb5
"""Diagram layout zones for scholia."""
function scholiaZones(ht, left_exterior)
	
	setdash("dot")
	sethue("olivedrab3")
	line(Point(left_exterior, 0), Point(left_exterior, ht))
end

# ╔═╡ 9bada34b-0748-474d-9a97-4dff4736540f
md"> **HMT data**"

# ╔═╡ d167eb70-f471-444b-a1a7-abcb5dcc8471
data = hmt_cex()

# ╔═╡ 2f4a3f9b-cf9d-4097-ad5d-20c3865eb392
dse = hmt_dse(data)[1]

# ╔═╡ 25441014-531a-498d-880e-a3a96dc90766
# ╠═╡ show_logs = false
pagerois = hmt_pagerois(data).index

# ╔═╡ c249767b-d6f0-4a2a-9fa9-2f8a818baadb
mss = hmt_codices(data)

# ╔═╡ ff7fa129-f715-4fb6-9701-6e4ea442c8c6
va = mss[6]

# ╔═╡ a98de624-0c28-4fa1-811d-edf0b1b76150
menu = map(va.pages[25:end]) do pg
	 pg.urn => objectcomponent(pg.urn)
end

# ╔═╡ a0ba2659-0b7b-482b-90f6-7baa83455722
md"""*Select a page and click* `Submit` $(@bind pg confirm(Select(menu)))"""

# ╔═╡ 882de14a-a64b-4a73-9bee-366ff5442577
md"""#### Analyzing manuscript page $(objectcomponent(pg))"""

# ╔═╡ 748768ed-4eed-4132-9973-f2a400862611
pg

# ╔═╡ 063cafbb-5d63-4569-a45b-12e98a4b7649
# ╠═╡ show_logs = false
pgdata = pageData(pg)

# ╔═╡ 73f0101c-12a1-4237-8fb2-1699bcb46383
mainscholia = isnothing(pgdata) ? nothing : filter(pr -> startswith(workcomponent(pr.scholion), "tlg5026.msA."), pgdata.textpairs)

# ╔═╡ 51937435-bb4e-4801-bfe0-740781475ad2
isnothing(pgdata) || isempty(pgdata.textpairs) ? md"" : md"""*Display `n` scholia* $(@bind scholialimit Slider(1:length(mainscholia), default = length(mainscholia), show_value = true))"""

# ╔═╡ 645ba380-a54f-4a79-ae0b-f24f59cc19b2
"Difference in pixels of current display between top of image and top of page illustrated."
topoffset = isnothing(pgdata) ? 0 : pageoffset_top(pgdata) * hpad

# ╔═╡ 6a09fe3f-171c-48f3-bf77-210408819131
pageheight = hpad - topoffset

# ╔═╡ 0f42eb04-fc71-4bf9-9390-4b9022b82a4b
md"> **Data to diagram all *Iliad* lines**"

# ╔═╡ acd34a2d-5af9-4a8e-a277-bb9b47d72631
iliadlines = filter(textsforsurface(pg, dse)) do txt
	startswith(workcomponent(txt), "tlg0012.tlg001")
end

# ╔═╡ 53def3ad-3d59-4004-9820-eca3ef3e9d52
iliadimages = map(iliadlines) do txt
	imagesfortext(txt, dse)[1]
end

# ╔═╡ e5d696f5-1237-4c9e-ba3c-b732114d917b
iliadrois = map(i -> MSPageLayout.imagefloats(i), iliadimages)

# ╔═╡ 2a739866-9153-4b74-95d7-13a210170f22
iliadcoords = zip(iliadlines, iliadrois) |> collect

# ╔═╡ a6beb710-6b66-4a9c-97dd-69131294cabd
"Compute unique list of *Iliad* lines with scholia commenting on them,
optionally filtering to include only scholia in the group identified by `siglum`.
"
function commentedon(pairlist; siglum = "msA")
	pairs = filter(pr -> startswith(workcomponent(pr.scholion),"tlg5026.$(siglum)."), pairlist)
	map(pr -> pr.iliadline, pairs) |> unique
end

# ╔═╡ 97843cce-f632-4681-9867-a547e8494ef7
"Diagram Iliad lines"
function diagramiliad(coords, withscholia, height, width)
	iliadpadding = 0.15 * w

	roilist = map(pr -> pr[2], coords)
	textlist = map(pr -> pr[1], coords)
	
	setdash("solid")
	sethue("snow3")

	for (i, v) in enumerate(roilist)
		itop = v[2] * height
		line(Point(iliadpadding, itop), Point(width - iliadpadding, itop), :stroke)
		
		ref = passagecomponent(textlist[i])
		settext("<span font='7'>$(ref)</span>", Point(15, itop), markup = true, valign = "center")
		if textlist[i] in withscholia
			halfway = width / 2
			circle(Point(halfway, itop), 3)
		end
	end
end

# ╔═╡ 954cb248-950d-4b4c-b82e-efd68a78bbd5
"""Plot in y the actual location of scholia on the page."""
function plotActualScholia(scholia, left, ht; siglum = "msA")
	sethue("olivedrab3")
	actual_scholia_x = left + 20
	for txtpair in scholia
		top = scholion_y_top(txtpair) * ht
		circle(Point(actual_scholia_x, top), 3, :fill)
	end
end

# ╔═╡ 8ded9235-9c80-4188-ac80-8a10f562663e
"""Plot a list of scholia y values."""
function plotHypothesisList(scholia, left, ht, colorname, insets = 1; siglum = "msA")
	sethue("thistle")
	actual_scholia_x = left + insets * 10
	for s in scholia
		circle(Point(actual_scholia_x, s), 3, :fill)
	end
end

# ╔═╡ 31caf334-aede-4171-83b7-d26c93c131e1
# ╠═╡ show_logs = false
if isnothing(pgdata) || isempty(pgdata.textpairs) 
	md""
else
@draw begin
	# Set coordinate system with origin at top left:
	translate(-1 * w/2, -1 * h/2)
	
	# Draw frame around page boundaries
	framepage(w,h)
	strokepath()
	# Mark off scholia zones
	scholiaZones(h, scholia_left)
	strokepath()
	
	# Draw iliad line locations
	havescholia = commentedon(pgdata.textpairs)
	diagramiliad(iliadcoords, havescholia, pageheight, scholia_left)

	# Plot actual y locations of main scholia
	plotActualScholia(mainscholia[1:scholialimit], scholia_left, h)


	tradl_yvalues = model_traditional_layout(pgdata)
	plotHypothesisList(tradl_yvalues, scholia_left, h, "thistle", 2)
	
end wpad hpad
end


# ╔═╡ c17328f0-1f50-4b81-af4f-8e286c952591
md"> **Image service**"

# ╔═╡ cf475337-52ea-406d-9a2a-2322f10630db
imgsvcurl = "http://www.homermultitext.org/iipsrv"

# ╔═╡ b678acd0-1cf5-4101-8029-ee0c446ce92b
imgsvcroot = "/project/homer/pyramidal/deepzoom"

# ╔═╡ aa12037b-f0d4-4769-a835-5b04557be557
imgservice = IIIFservice(imgsvcurl, imgsvcroot)

# ╔═╡ 82ed9fa1-75a3-4c60-84db-f1f75e049add
function pageimage(pg, roituples; ht = 200)
	prs = filter(pr -> pr[1] == pg, roituples)
	if isempty(prs) 
		nothing 
	else
		imgu = prs[1][2]
		iifrequest = url(imgu, imgservice, ht = ht)
		f = Downloads.download(iifrequest)
		img = load(f)
		rm(f)
		img
	end
end

# ╔═╡ 721e3e0a-48d2-4569-895e-77e519bbf273
pgimg = pageimage(pg, pagerois)

# ╔═╡ 35f39a9d-4362-484d-a4bf-8d284ea6aab3
screened = RGBA.(pgimg, alpha)

# ╔═╡ Cell order:
# ╟─d2424f38-d821-44b6-8fd9-365ee695f324
# ╠═36927b11-2363-4d84-89a3-77cb4a63939a
# ╟─874b7016-1e70-11ee-06bd-6dffcdd850d4
# ╟─a0ba2659-0b7b-482b-90f6-7baa83455722
# ╟─882de14a-a64b-4a73-9bee-366ff5442577
# ╟─0e71905f-081e-4615-bee8-247ee9cbfa2e
# ╟─51937435-bb4e-4801-bfe0-740781475ad2
# ╟─31caf334-aede-4171-83b7-d26c93c131e1
# ╟─73f0101c-12a1-4237-8fb2-1699bcb46383
# ╟─34409b3f-cb5c-409c-bebf-03befe1b6492
# ╠═35f39a9d-4362-484d-a4bf-8d284ea6aab3
# ╠═721e3e0a-48d2-4569-895e-77e519bbf273
# ╠═82ed9fa1-75a3-4c60-84db-f1f75e049add
# ╟─dcce74ec-4d0c-4017-bcc5-58a6e07dbfe4
# ╟─36973a8c-a31e-4d93-a61d-6906786ec079
# ╟─30f78169-805d-4c38-89c4-115ca7e4f3e7
# ╟─6302db98-daf9-480d-bdda-2e350245a1bc
# ╟─65ace1d4-eb73-4924-875c-d24798f6b8cd
# ╟─b405679c-ec6a-40e6-b8f5-44889233db9d
# ╟─8ca6b28d-fb26-475b-9a1d-f8091c246037
# ╠═df5ff74c-435c-43ad-9e70-d23418b28721
# ╟─9e630977-1097-499f-bb7c-a79fb4e5cfb5
# ╟─645ba380-a54f-4a79-ae0b-f24f59cc19b2
# ╠═6a09fe3f-171c-48f3-bf77-210408819131
# ╟─9bada34b-0748-474d-9a97-4dff4736540f
# ╟─d167eb70-f471-444b-a1a7-abcb5dcc8471
# ╠═2f4a3f9b-cf9d-4097-ad5d-20c3865eb392
# ╠═25441014-531a-498d-880e-a3a96dc90766
# ╟─c249767b-d6f0-4a2a-9fa9-2f8a818baadb
# ╠═ff7fa129-f715-4fb6-9701-6e4ea442c8c6
# ╠═a98de624-0c28-4fa1-811d-edf0b1b76150
# ╠═748768ed-4eed-4132-9973-f2a400862611
# ╠═063cafbb-5d63-4569-a45b-12e98a4b7649
# ╟─0f42eb04-fc71-4bf9-9390-4b9022b82a4b
# ╠═acd34a2d-5af9-4a8e-a277-bb9b47d72631
# ╠═53def3ad-3d59-4004-9820-eca3ef3e9d52
# ╠═e5d696f5-1237-4c9e-ba3c-b732114d917b
# ╠═2a739866-9153-4b74-95d7-13a210170f22
# ╠═a6beb710-6b66-4a9c-97dd-69131294cabd
# ╠═97843cce-f632-4681-9867-a547e8494ef7
# ╟─954cb248-950d-4b4c-b82e-efd68a78bbd5
# ╟─8ded9235-9c80-4188-ac80-8a10f562663e
# ╟─c17328f0-1f50-4b81-af4f-8e286c952591
# ╠═cf475337-52ea-406d-9a2a-2322f10630db
# ╠═b678acd0-1cf5-4101-8029-ee0c446ce92b
# ╠═aa12037b-f0d4-4769-a835-5b04557be557
