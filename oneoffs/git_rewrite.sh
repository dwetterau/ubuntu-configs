OLD_EMAIL="davidw.wetterau@gmail.com"
NEW_NAME="David Wetterau"
NEW_EMAIL="david.wetterau@gmail.com"

git filter-repo --force --commit-callback '
if commit.author_email == b"'"$OLD_EMAIL"'":
    commit.author_name = b"'"$NEW_NAME"'"
    commit.author_email = b"'"$NEW_EMAIL"'"
if commit.committer_email == b"'"$OLD_EMAIL"'":
    commit.committer_name = b"'"$NEW_NAME"'"
    commit.committer_email = b"'"$NEW_EMAIL"'"
'

