#!/usr/bin/env bash
set -euo pipefail

pushd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null

content_file="config-files/bashrc.sh"
bashrc="$HOME/.bashrc"

begin_marker='# Begin settings from setup-bash.sh in "personal-config-files" repository'
end_marker='# End settings from setup-bash.sh in "personal-config-files" repository'

touch "$bashrc"

content="$(cat "$content_file")"

# Remove any existing block (marker through marker), along with surrounding blank lines
BEGIN_MARKER="$begin_marker" END_MARKER="$end_marker" perl -0777 -i -pe '
    my $b = quotemeta($ENV{BEGIN_MARKER});
    my $e = quotemeta($ENV{END_MARKER});
    s/\n*$b.*?$e\n*/\n\n/gs;
' "$bashrc"

# Collapse trailing blank lines left behind by the removal
perl -0777 -i -pe 's/\n+\z/\n/' "$bashrc"

# Append the content with exactly one blank line before and after
printf '\n%s\n\n' "$content" >> "$bashrc"
