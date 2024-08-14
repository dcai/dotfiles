switch (uname)
    case Linux
        source_script $FISHHOME/dialect/linux.fish
    case Darwin
        source_script $FISHHOME/dialect/macos.fish
        #case FreeBSD NetBSD DragonFly
        #case '*'
end
