function fish_greeting --description Greeting
    # set -l COLLECTIONS tang300 song100 chinese
    # set -l COLLECTIONS funny
    if type -q fortune
        if type -q lolcat
            # fortune -e $COLLECTIONS | lolcat
            fortune | lolcat
        else
            # fortune -e $COLLECTIONS
            fortune
        end
        if type -q cowsay
            echo 'WOW such MOTD very poetry' | cowsay -f small
        end
    end
end
