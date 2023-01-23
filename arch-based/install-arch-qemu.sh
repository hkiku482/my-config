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
        "Worldwide": {
            "https://mirror.rackspace.com/archlinux/$repo/os/$arch": true
        }
    },
    },
    "nic": {
        "type": "nm"
    },
    "ntp": true,
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

archinstall --config user_configuration.json --disk-layout user_disk_layout.json --creds user_credentials.json 
