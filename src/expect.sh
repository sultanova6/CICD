#!/usr/bin/expect -f
spawn ./copy.sh

expect {
	"*fingerprint*" { send -- "yes\r" }
	"*password*" { send -- "111\r" }
}

expect EOF
