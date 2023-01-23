tee user_configuration.json << EOF
{
    "audio": null,
    "bootloader": "grub-install",
    "harddrives" : [
        "/dev/vda"
    ],
    "hostname": "archlinux",
    "kernels": [
        "linux"
    ],
    "mirror-region": {
        "Japan": {
            "http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch": true,
            "http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/$repo/os/$arch": true,
            "http://mirrors.cat.net/archlinux/$repo/os/$arch": true,
            "https://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch": true,
            "https://mirror.saebasol.org/archlinux/$repo/os/$arch": true,
            "https://mirrors.cat.net/archlinux/$repo/os/$arch": true
        }
    },
    "nic": {
        "type": "NM"
    },
    ntp: true,
    "profile": null,
    "script": "guided",
    "swap": false,
    "version": "2.5.1"
}
EOF

tee user_disk_layout.json << EOF
{
    "/dev/vda": {
        "partitions" : [
            {
                "boot": true,
                "encrypted": false,
                "filesystem": {
                    "format": "fat32"
                },
                "mountpoint": "/boot",
                "size": "512MiB",
                "start": "3MiB",
                "type": "primary",
                "wipe": "true"
            },
            {
                "encrypted": false,
                "filesystem": {
                    "format": "ext4",
                    "mount_options": []
                },
                "mountpoint": "/",
                "size": "100%",
                "start": "515MiB",
                "type": "primary",
                "wipe": true
            }
        ],
        "wipe": true
    }
}
EOF

tee user_credentials.json << EOF
{
    "!users": [
        {
            "!password": "archuser",
            "sudo": true,
            "username": "arch"
        }
    ]
}
EOF

archinstall --config user_configuration.json --disk user_disk_layout.json --creds user_credentials.json 
