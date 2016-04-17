node default {
  include baseconfig
  include cron-puppet
  include roles::dockerhost
}
