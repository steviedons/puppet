node default {
  include baseconfig
  include cron-puppet
  include profiles::docker
}
