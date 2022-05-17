function up-or-search --description 'Search back or move cursor up 1 line'
    # If we are already in search mode, continue
    if commandline --search-mode
        commandline -f history-search-backward
        return
    end

    # If we are navigating the pager, then up always navigates
    if commandline --paging-mode
        commandline -f up-line
        return
    end

    # We are not already in search mode.
    # If we are on the top line, start search mode,
    # otherwise move up
    set -l lineno (commandline -L)

    switch $lineno
        case 1
            commandline -f history-search-backward
            # 在原up-or-search的基础上，增加了历史记录合并
            history merge # <-- new

        case '*'
            commandline -f up-line
    end
end
