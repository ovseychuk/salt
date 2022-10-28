salt-minion:
    pkgrepo.managed:
      - humanname: SaltStack Latest Release Channel for Ubuntu $releasever
      - name: deb https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/latest jammy main
      - file: /etc/apt/sources.list.d/salt.list
      - gpgkey: https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/latest/salt-archive-keyring.gpg
      - gpgcheck: 1
      - enabled: 1
    pkg:
      - installed
      - require:
        - pkgrepo: salt-latest
    service:
      - running
      - enable: True
      - require:
        - pkg: salt-minion
      - watch:
        - file: /etc/salt/minion

/etc/salt/minion:
  file:
    - source: salt://salt-minion/minion
    - managed
    - user: root
    - group: root
    - mode: 644
    - template: jinja