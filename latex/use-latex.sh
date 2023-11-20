REPOSITORY_ROOT="https://raw.githubusercontent.com/hkiku482/my-config/main"

sudo pacman -S texlive texlive-lang biber --needed

# NOTE: `latexindent` was broken
sudo cpan Log::Log4perl
sudo cpan Log::Dispatch
sudo cpan YAML::Tiny
sudo cpan File::HomeDir
sudo cpan Unicode::GCString

curl "${REPOSITORY_ROOT}/latex/.latexmkrc" -o ~/.latexmkrc
