REPOSITORY_ROOT="https://raw.githubusercontent.com/hkiku482/my-config/main"

mkdir -p /tmp/texlinstall
curl https://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz -o /tmp/texinstall/install-tl-unx.tar.gz
tar xvf install-tl-unx.tar.gz -C /tmp/texinstall
sudo $(ls /tmp/texinstall/install-tl-2*/install-tl)

sudo cpan Log::Log4perl
sudo cpan Log::Dispatch
sudo cpan YAML::Tiny
sudo cpan File::HomeDir
sudo cpan Unicode::GCString

curl "${REPOSITORY_ROOT}/latex/.latexmkrc" -o ~/.latexmkrc
