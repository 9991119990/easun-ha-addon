# EASUN Solar Monitor Home Assistant Add-on

Monitor pro EASUN SHM II solární měniče přes USB/RS232 rozhraní.

## Funkce

- Real-time monitoring EASUN SHM II měničů
- Automatická MQTT discovery pro Home Assistant
- Podpora multi-arch (RPi, x86, atd.)
- Sledování PV výkonu, baterie, AC výstupu a dalších parametrů

## Podporovaná zařízení

- EASUN SHM II 7K
- Další EASUN měniče s PI30 protokolem

## Instalace

1. Přidejte tento repozitář do Home Assistant:
   - Supervisor → Add-on Store → ⋮ → Repositories
   - Přidat URL tohoto repozitáře

2. Najděte "EASUN Solar Monitor" v seznamu add-onů a nainstalujte

3. Nakonfigurujte add-on:
   - `device`: USB port měniče (výchozí `/dev/ttyUSB0`)
   - `mqtt_*`: MQTT nastavení (automaticky z HA)
   - `update_interval`: Interval aktualizace v sekundách

4. Spusťte add-on

## Dostupné senzory

- **PV Solar**: napětí, proud, výkon
- **Baterie**: napětí, kapacita, nabíjecí/vybíjecí výkon, status
- **AC výstup**: napětí, frekvence, výkon, zatížení
- **Systém**: teplota měniče, režim (grid/battery), grid napětí

## Konfigurace

```yaml
device: /dev/ttyUSB0
update_interval: 10
```

MQTT nastavení se automaticky převezme z Home Assistant.