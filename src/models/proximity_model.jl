"""Compute layout of scholia on page `mspage` using proximity model.
Optionally limit consideration to scholia with siglum `siglum`.
$(SIGNATURES)
"""
function model_by_proximity(mspage::MSPage; siglum = "msA", digits = 3)
    scholialist = isempty(siglum) || isnothing(siglum) ? mspage.scholia : filter(pr -> workid(pr.scholion) == siglum, mspage.scholia)
    n = length(scholialist)
    s_heights = scholion_heights(filteredPage)
    
    #=
    model = Model(HiGHS.Optimizer)
    @variable(model, yval[i = 1:n])
    @constraint(model, domainlimits, 0 .<= yval .<= 1)
    @constraint(model, cumulativeconstraint, yval .>= totals)

    @objective(model, Min, sum(yval[i] - iliad_ys[i] for i in 1:n))

    optimize!(model)
    status = termination_status(model)
    if status != OPTIMAL 
        return nothing
    end
    solution_summary(model)
    stringvalue = join(round.(value.(yval), digits = digits), ",")
    opt_ys= split(stringvalue, ",")
    opt_ys= map(x->round(parse(Float64, x), digits = digits), opt_ys)
    return opt_ys

    =#
end