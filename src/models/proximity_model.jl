"""Compute layout of scholia on page `mspage` using proximity model.
Optionally limit consideration to scholia with siglum `siglum`.
Returns a list of y values.
$(SIGNATURES)
"""
function model_by_proximity(mspage::MSPage; siglum = "msA", digits = 3)
    scholialist = isempty(siglum) || isnothing(siglum) ? textpairs(mspage) : filter(pr -> workid(pr.scholion) == siglum, textpairs(mspage))
    n = length(scholialist)
    s_heights = scholion_height.(scholialist)
    iliad_ys = iliad_top.(scholialist)
    @info("Iliad ys are", iliad_ys)
    @info("Scholion hts are", s_heights)

    model = Model(HiGHS.Optimizer)
    @variable(model, yval[i = 1:n])
    @constraint(model, domainlimits, page_top(mspage) .<= yval .<= page_bottom(mspage))
    #@constraint(model, domainlimits, 0 .<= yval .<= 1)
    
    
    for i in 2:n
        @constraint(model, yval[i] <= yval[i-1] + s_heights[i-1])
    end


    @objective(model, Min, sum((yval[i] - iliad_ys[i])^2 for i in 1:n))
    optimize!(model)
    status = termination_status(model)
    if status != OPTIMAL 
        @warn("model_by_proximity: failed to reach optimal result for page $(mspage)")
        return
    else
        yvallist = value.(yval)
        map(yvallist) do y
            round(y, digits = digits)
        end
    end
end