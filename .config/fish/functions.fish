function !!
    eval $history[1]
end

function yarn-test-record-switch
    set -l line (commandline)

    if string match -q -r "^(yr|yarn test:e2e:record) " $line
        commandline -r (string replace -r "^(yr|yarn test:e2e:record)" "yt" $line)
    else if string match -q -r "^(yt|yarn test:e2e) " $line
        commandline -r (string replace -r "^(yt|yarn test:e2e)" "yr" $line)
    end
end
