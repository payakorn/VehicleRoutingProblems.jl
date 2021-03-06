function show_opt_solution(x, n, num_vehicle, name)
    tex = ""

    # check location
    location = joinpath(@__DIR__, "..", "opt_solomon", "$name") 
    if isfile(location) == false
        mkpath(location)
    end

    # create file csv to store solution
    io = open(joinpath(location, "$name-$n-$num_vehicle"), "w")

    all_job = 1:n
    for k in 1:num_vehicle
        job = [0]
        last_job = -1
        for i in 1:n
            if value.(x[0, i, k]) == 1.0
                job = append!(job, i)
                break
            end
        end
        while last_job != 0
            j = job[end]
            for i in 0:n
                if i != j
                    if value(x[j, i, k]) == 1.0
                        job = append!(job, i)
                        last_job = i
                        break
                    end
                end
            end
        end
        println("vehicle $k $(job)")
        for item in job[2:end-1]
            write(io, "$item ")
        end
        tex *= "vehicle $k: $(job[2:end-1])\n"
        write(io, "\n")
    end
    close(io)
    return tex
end

function print_solution()
    for k in K
        println("$k")
    end
end