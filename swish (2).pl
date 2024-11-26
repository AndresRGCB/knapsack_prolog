% solve(Items, MaxWeight, Solution, TotalWeight, TotalProfit)
solve(Items, MaxWeight, Solution, TotalWeight, TotalProfit) :-
    find_best_solution(Items, MaxWeight, [], 0, 0, Solution, TotalWeight, TotalProfit).

% If no items left return
find_best_solution([], _, BestSet, BestWeight, BestProfit, BestSet, BestWeight, BestProfit).

% Recursive case: Try including or excluding the current item
find_best_solution([[Weight, Profit]|T], MaxWeight, CurrentSet, CurrentWeight, CurrentProfit,
                   BestSet, BestWeight, BestProfit) :-
    % branch1, include if possible
    (NewWeight is CurrentWeight + Weight,
     NewWeight =< MaxWeight,
     NewProfit is CurrentProfit + Profit,
     find_best_solution(T, MaxWeight, [[Weight, Profit]|CurrentSet], NewWeight, NewProfit,
                        CandidateSet1, CandidateWeight1, CandidateProfit1)
    ;
     CandidateSet1 = CurrentSet, CandidateWeight1 = CurrentWeight, CandidateProfit1 = CurrentProfit
    ),

    % branch2, exculde
    find_best_solution(T, MaxWeight, CurrentSet, CurrentWeight, CurrentProfit,
                       CandidateSet2, CandidateWeight2, CandidateProfit2),

    % Save best solution
    (CandidateProfit1 > CandidateProfit2 ->
        (BestSet = CandidateSet1, BestWeight = CandidateWeight1, BestProfit = CandidateProfit1)
    ;
        (BestSet = CandidateSet2, BestWeight = CandidateWeight2, BestProfit = CandidateProfit2)
    ).
