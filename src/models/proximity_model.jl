"""Compute layout of scholia on page `mspage` using proximity model.
Optionally limit consideration to scholia with siglum `siglum`.
$(SIGNATURES)
"""
function model_by_proximity(mspage::MSPage; siglum = "msA", digits = 3)
    scholialist = isempty(siglum) || isnothing(siglum) ? mspage.scholia : filter(pr -> workid(pr.scholion) == siglum, mspage.scholia)
    n = length(scholialist)
    s_heights = scholion_height.(scholialist)
    iliad_ys = iliad_top.(scholialist)
    totals = []
    for i in 1:n
        push!(totals, sum(s_heights[1:i]))
    end
   
    model = Model(HiGHS.Optimizer)
    @variable(model, yval[i = 1:n])
    @constraint(model, domainlimits, 0 .<= yval .<= 1)
    @constraint(model, cumulativeconstraint, yval .>= totals)

    @objective(model, Min, sum(yval[i] - iliad_ys[i] for i in 1:n))

    optimize!(model)
    status = termination_status(model)
    if status != OPTIMAL 
        @warn("model_by_proximity: failed to reach optimal result for page $(mspage)")
        nothing
    else
        yvallist = value.(yval)
        map(yvallist) do y
            round(y, digits = digits)
        end
    end
end