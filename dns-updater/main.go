package main

import (
	"fmt"
	"io/ioutil"
	"net"
	"net/http"
	"os"

	yaml "gopkg.in/yaml.v2"
)

func main() {
	var c config
	c.loadConfig()
	c.updateDomains()
}

func (c *config) loadConfig() []domain {
	yamlFile, err := ioutil.ReadFile("config.yml")
	noError(err)
	yaml.Unmarshal(yamlFile, c)
	return []domain{}
}

func (c *config) updateDomains() {
	currentIP := currentExternalIp()
	for _, domain := range c.Domains {
		if ipHasChanged(domain, currentIP) {
			domain.update(c.Password, currentIP)
		}
	}
}

func currentExternalIp() string {
	resp, err := http.Get("http://dynamicdns.park-your-domain.com/getip")
	noError(err)

	body, err := ioutil.ReadAll(resp.Body)
	noError(err)

	return string(body)
}

func ipHasChanged(domain domain, currentIP string) bool {
	ips, err := net.LookupIP(domain.fullHost())
	noError(err)
	for _, ip := range ips {
		if len(ip) == net.IPv4len {
			if string(ip) == currentIP {
				return false
			}
		}
	}
	return true
}

func (d *domain) update(password string, currentIP string) {
	uri := fmt.Sprintf("https://dynamicdns.park-your-domain.com/update?host=%s&domain=%s&password=%s&ip=%s", d.Host, d.Domain, password, currentIP)
	resp, err := http.Get(uri)
	noError(err)

	body, err := ioutil.ReadAll(resp.Body)
	noError(err)

	fmt.Println("updated domain response: ", string(body))
}

func (d *domain) fullHost() string {
	return fmt.Sprintf("%s.%s", d.Host, d.Domain)
}

func noError(err error) {
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

type config struct {
	Domains  []domain `yaml:"domains"`
	Password string   `yaml:"password"`
}

type domain struct {
	Domain string `yaml:"domain"`
	Host   string `yaml:"host"`
}
