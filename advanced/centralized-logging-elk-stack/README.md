
````markdown
# 📦 Centralized Logging with ELK Stack

A step-by-step setup guide to implement centralized logging using the **ELK Stack**: Elasticsearch, Logstash, and Kibana.

---

## 🧰 Stack Components

- **Elasticsearch** – Search & Index log data
- **Logstash** – Parse and send logs to Elasticsearch
- **Kibana** – Visualize and explore logs via UI
- **Rsyslog/Beats** – Log forwarders from client machines

---

## 🏗️ Architecture

```text
[Client Servers] ──► [Logstash] ──► [Elasticsearch] ──► [Kibana Dashboard]
                          ↑
                     (Rsyslog/Beats)
````

---

## 🔧 Installation Steps

### ✅ 1. Install Elasticsearch

```bash
sudo apt update
sudo apt install elasticsearch
```

* Edit: `/etc/elasticsearch/elasticsearch.yml`

```yaml
network.host: 0.0.0.0
discovery.type: single-node
```

---

### ✅ 2. Install Logstash

```bash
sudo apt install logstash
```

* Create config: `/etc/logstash/conf.d/syslog.conf`

```conf
input {
  udp {
    port => 514
    type => "syslog"
  }
}
filter {
  grok {
    match => { "message" => "%{SYSLOGTIMESTAMP:timestamp} %{SYSLOGHOST:host} %{DATA:program}: %{GREEDYDATA:msg}" }
  }
}
output {
  elasticsearch {
    hosts => ["http://localhost:9200"]
    index => "syslog-%{+YYYY.MM.dd}"
  }
}
```

---

### ✅ 3. Install Kibana

```bash
sudo apt install kibana
```

* Edit: `/etc/kibana/kibana.yml`

```yaml
server.host: "0.0.0.0"
elasticsearch.hosts: ["http://localhost:9200"]
```

Access at: `http://<your-server-ip>:5601`

---

## 🖥️ Client Configuration (rsyslog)

Edit `/etc/rsyslog.conf`:

```conf
*.* @<elk-server-ip>:514
```

Restart:

```bash
sudo systemctl restart rsyslog
```

---

## 📊 Kibana Dashboard

* Go to `Discover`
* Create index pattern: `syslog-*`
* Save views or charts to a dashboard

---

## 🔐 Security (Optional)

* Enable TLS on Elasticsearch
* Use reverse proxy (like Nginx) for Kibana
* Configure authentication

---

## 📌 Author

* 👤 Atikul Islam
* 🌐 GitHub: https://github.com/iamatikahad

---

## 📝 License

This project is licensed under the MIT License.

```

