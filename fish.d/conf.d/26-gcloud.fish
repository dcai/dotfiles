if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]
    . "$HOME/google-cloud-sdk/path.fish.inc"
end

set -gx GOOGLE_REGION australia-southeast1
set -gx GOOGLE_ZONE australia-southeast1-a
set -gx GOOGLE_PROJECT foleo
set -gx GOOGLE_CREDENTIALS "$HOME/serviceaccount.$GOOGLE_PROJECT.json"
