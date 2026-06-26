# foitintune
Repository to handle all things intune.

# M42 FastViewer – Användardokumentation

> **Produkt:** Matrix42 FastViewer Webconsole  
> **Språk:** Svenska  
> **Källa:** Matrix42 officiell dokumentation  
> **Senast uppdaterad (originalkälla):** 2 december 2025

---

## Innehållsförteckning

1. [Huvudpanelen (Dashboard)](#1-huvudpanelen-dashboard)
   - [Översikt](#11-översikt)
   - [Huvudområdet](#12-huvudområdet)
   - [Vänster sidopanel](#13-vänster-sidopanel)
     - [Sökfält](#sökfält)
     - [Aktiva anslutningar](#aktiva-anslutningar)
     - [Favoriter](#favoriter)
     - [Alla enheter](#alla-enheter)
   - [Menyalternativ (övre högra hörnet)](#14-menyalternativ-övre-högra-hörnet)
     - [Sidopanel](#sidopanel)
     - [Ad Hoc-session](#ad-hoc-session)
     - [Inställningar](#inställningar)
2. [Hantera anslutningar](#2-hantera-anslutningar)
   - [Översikt](#21-översikt)
   - [Installera klientprogramvara](#22-installera-klientprogramvara)
   - [Statusindikatorerna](#23-statusindikatorerna)
   - [Anslutningstyper](#24-anslutningstyper)
     - [Desktop (Användarnamn)](#desktop-användarnamn)
     - [CMD (Användarnamn / Inloggning)](#cmd-användarnamn--inloggning)
     - [PowerShell (Användarnamn / Inloggning)](#powershell-användarnamn--inloggning)
     - [Filöverföring (Användarnamn / Inloggning)](#filöverföring-användarnamn--inloggning)
     - [Starta om (Reboot)](#starta-om-reboot)
   - [Ansluta till en klient](#25-ansluta-till-en-klient)
   - [Fjärrskrivbord – Funktioner](#26-fjärrskrivbord--funktioner)
     - [Växla helskärmsläge](#växla-helskärmsläge)
     - [Visningsläge](#visningsläge)
     - [Ändra upplösning](#ändra-upplösning)
     - [Dölj / Visa skrivbordsunderlägg](#dölj--visa-skrivbordsunderlägg)
     - [Urklipp aktiverat / inaktiverat](#urklipp-aktiverat--inaktiverat)
     - [Tangentbordskommandon](#tangentbordskommandon)
     - [Prestandaövervakning](#prestandaövervakning)
   - [Ansluta till CMD](#27-ansluta-till-cmd)
   - [Ansluta till PowerShell](#28-ansluta-till-powershell)
   - [Ansluta till filöverföring](#29-ansluta-till-filöverföring)

---

## 1. Huvudpanelen (Dashboard)

### 1.1 Översikt

När du loggat in ger M42 FastViewer-dashboarden åtkomst till fjärrenheter, anslutningsstatus och övriga alternativ.

---

### 1.2 Huvudområdet

Det här området används för att visa fjärranslutningen.

Om inga anslutningar är aktiva visas ett välkomstmeddelande i huvudområdet.

> **Tips:** Hur du hanterar fjärranslutningar beskrivs i avsnitt 2 – [Hantera anslutningar](#2-hantera-anslutningar).

---

### 1.3 Vänster sidopanel

Längst upp i sidopanelen finns en **Uppdateringsknapp** som uppdaterar listan med alla enheter i samtliga vyer.

#### Sökfält

Använd sökfältet för att snabbt hitta en specifik enhet, mapp eller anslutningsalternativ via fritextsökning.

Sökresultaten visas under rubriken **"Sökresultat [antal träffar]"**. Som standard visas alla enheter.

**Exempel:** Sökning på "test" returnerar enheter vars namn *börjar* med "test", exempelvis **TestPC** – men inte **PCTest**.

> Sökningen fungerar som en **prefixsökning** – den matchar alltid från början av ordet.

---

#### Aktiva anslutningar

Visar de anslutningar som för närvarande är aktiva.

Antalet aktiva sessioner visas inom parentes (0 när inga är aktiva).

Tillgängliga åtgärder per aktiv session:

- **Pennikon** – Ändra sessionens namn.
- **Frånkopplingsikon** – Koppla snabbt från sessionen. Obs! Ingen bekräftelse begärs vid frånkoppling.

---

#### Favoriter

Listar enheter som du har markerat som favoriter för snabb åtkomst.

En grön punkt bredvid enheten visar att den är **online och tillgänglig**.

---

#### Alla enheter

Visar samtliga enheter och grupper i en trädstruktur med mappar (t.ex. Matrix42, Frankfurt, Milano, Wien).

> En enhet kan bara finnas i **en mapp åt gången**.

Alla nyregistrerade klienter placeras automatiskt i mappen **"\_New Clients"**.

**Navigering:**

- Klicka på en mapp för att expandera den och se de tillgängliga fjärragenterna.
- Expandera en enskild enhet för att se alla tillgängliga åtgärder för den enheten.
- **Dra och släpp** enheter för att flytta dem mellan mappar.

---

### 1.4 Menyalternativ (övre högra hörnet)

#### Sidopanel

Använd knappen **Sidopanel** för att dölja eller visa den vänstra sidopanelen.

---

#### Ad Hoc-session

Med **Ad Hoc-knappen** kan du skapa en tillfällig session utan att behöva ha en förregistrerad enhet.

**Så här skapar du en Ad Hoc-session:**

1. Klicka på **Ad Hoc**-knappen.
2. En inställningspanel öppnas. Ange ett sessionsnamn och välj önskad åtkomsttyp/typer.
3. Klicka på **OK**.
4. En väntevy visas med **sessions-ID** och en **länk** till Ad Hoc-sessionen.

För att gå till helskärmsläge, klicka på helskärmsikonen. I helskärmsläge visas alternativ för att avsluta helskärm (vänster) och koppla från sessionen (höger) när du håller muspekaren över ikonen.

> **Obs!** Ad Hoc-sessioner stöds för närvarande endast på **Windows, iOS och Android**.

---

#### Inställningar

Klicka på **Alternativikonen** för att öppna inställningsmenyn.

Se artikeln *"M42 FastViewer Settings"* för mer information om tillgängliga inställningar.

---

## 2. Hantera anslutningar

### 2.1 Översikt

Varje registrerad enhet erbjuder en rullgardinsmeny med åtgärder för att hantera och interagera med systemet på distans. Dessa verktyg gör det möjligt att ge support, utföra underhåll eller överföra filer.

> **Viktigt:** Bekräfta alltid vilken session du riktar dig mot för att undvika att störa fel användare!

---

### 2.2 Installera klientprogramvara

Slutanvändaren måste installera klientprogramvaran så att datorn kan fjärrhanteras.

**Så här skapar du ett installationspaket:**

1. Gå till **Inställningar → Ladda ned agent** (Download Agent).
2. Välj önskade alternativ för installationsfilen.
3. Klicka på **Starta nedladdning** och kör filen på måldatorn.

> För **Android och Apple**-enheter används respektive app-butik för att ladda ned klientprogramvaran.

---

### 2.3 Statusindikatorerna

| Indikator | Betydelse |
|---|---|
| Grön punkt bredvid enheten | Enheten är **online och nåbar** |
| Utgråade ikoner / otillgängliga åtgärder | Kan indikera otillräckliga behörigheter, att enheten är offline eller att sessionskontexten inte är tillgänglig |

---

### 2.4 Anslutningstyper

#### Desktop (Användarnamn)

Öppnar en **fjärrskrivbordssession** till den valda användarens session.

- Tillåter full kontroll och skärmdelning.
- Slutanvändaren kan se vad som görs på skärmen.

---

#### CMD (Användarnamn / Inloggning)

Öppnar en **Kommandotolk-session** på distans. Kommandotolken visas **inte** för användaren.

- **Användarnamn:** Interagerar med den aktiva användarsessionen.
- **Inloggning:** Kräver att du anger inloggningsuppgifter innan anslutning upprättas. Gör det möjligt att använda ett annat konto (t.ex. ett administratörskonto) än den inloggade användaren.

---

#### PowerShell (Användarnamn / Inloggning)

Öppnar en **PowerShell-terminal** för avancerad systemskriptning. Sessionen visas **inte** för användaren.

- **Användarnamn:** PowerShell körs inom den inloggade användarens session.
- **Inloggning:** Kräver att du anger inloggningsuppgifter innan anslutning upprättas. Användbart för att köra skript eller utföra mer avancerade administratörsuppgifter med ett annat konto.

---

#### Filöverföring (Användarnamn / Inloggning)

Ger åtkomst till fjärrenhetens filsystem för att ladda upp, ladda ned eller hantera filer. Sessionen är **inte** synlig för användaren.

- **Användarnamn:** Kopplar till den aktiva användarsessionen.
- **Inloggning:** Kopplar till inloggningsskärmen eller systemkontexten med angivna inloggningsuppgifter.

---

#### Starta om (Reboot)

Skickar ett **fjärromstartskommando** till klienten.

Använd detta efter installationer, uppdateringar eller felsökning.

---

### 2.5 Ansluta till en klient

Det finns fyra huvudsakliga sätt att ansluta till en klient:

| Anslutningstyp | Beskrivning | Synlig för slutanvändaren? |
|---|---|---|
| **Desktop** | Samma skrivbordsupplevelse som slutanvändaren | Ja |
| **CMD** | Kommandorad från klientdatorn | Nej |
| **PowerShell** | PowerShell från klientdatorn | Nej |
| **Filöverföring** | Överför filer till/från klientdatorn | Nej |

**Ansluta via sidopanelen:**

Klicka på **anslut/frånkopplingsikonen** i sidopanelen (ikonen ändras när du håller muspekaren över den).

**Ansluta via huvudpanelen:**

Använd knapparna **Anslut** eller **Anslut med alternativ profil** i huvudpanelen.

---

### 2.6 Fjärrskrivbord – Funktioner

När du är ansluten till en klient visas klientens skrivbord i huvudpanelen. Längst upp finns ett fält med snabbåtgärder.

#### Växla helskärmsläge

Klicka på **helskärmsikonen** för att gå till helskärmsläge.

I helskärmsläge visas följande alternativ när du håller muspekaren över ikonen:

- **Vänster ikon:** Avsluta helskärm
- **Höger ikon:** Koppla från sessionen

---

#### Visningsläge

Välj hur skrivbordet ska visas i webbläsarfönstret:

| Läge | Beskrivning |
|---|---|
| **Auto-Scroll** | Om upplösningen är för hög rullas vyn automatiskt runt skrivbordet |
| **Manual Scroll** | Rulla manuellt med hjälp av rullningslisterna i hörnen |
| **Zoom to Fit** | Zoomar automatiskt skärmen så att den passar i webbläsarfönstret |

---

#### Ändra upplösning

Klientskrivbordets upplösning kan ändras via **upplösningsmenyn** i snabbåtgärdsfältet.

---

#### Dölj / Visa skrivbordsunderlägg

Dölj eller visa skrivbordsunderlägget på klientens skrivbord.

---

#### Urklipp aktiverat / inaktiverat

Aktivera eller inaktivera möjligheten att kopiera data till urklipp på klientdatorn.

---

#### Tangentbordskommandon

Kör tangentbordskommandon på klientens dator. Tillgängliga kommandon:

| Kommando | Funktion |
|---|---|
| `Ctrl + Alt + Del` | Visa säkerhetsskärm |
| `Windows + R` | Kör (Run) |
| `Windows + E` | Utforskaren (Explorer) |
| `Shift + Ctrl + Esc` | Aktivitetshanteraren (Task Manager) |
| `Windows + D` | Visa/dölj alla fönster |
| `Ctrl + Esc` | Öppna/stäng Start-menyn |
| `Alt + F4` | Stäng aktivt fönster |
| `Alt + Tab` | Växla fönster |
| `Alt + Shift + Tab` | Växla till föregående fönster |
| `Alt + Space` | Öppna kontrollmenyn |
| `Windows + Ctrl + O` | Aktivera/inaktivera skärmtangentbordet |

---

#### Prestandaövervakning

Öppna **prestandaövervakaren** för den aktuella sessionen via snabbåtgärdsfältet.

---

### 2.7 Ansluta till CMD

Startar en **Kommandotolkssession** på klientdatorn.

> Obs! Sessionen är **osynlig** för klientdatorns användare.

---

### 2.8 Ansluta till PowerShell

Startar en **PowerShell-session** på klientdatorn.

> Obs! Sessionen är **osynlig** för klientdatorns användare.

---

### 2.9 Ansluta till filöverföring

Startar en **filöverföringssession** på klientdatorn.

> Obs! Sessionen är **osynlig** för klientdatorns användare.

Filer kan laddas upp till klientdatorn via **dra och släpp** eller med knappen **Ladda upp** när du befinner dig i en lämplig mapp.

**Tillgängliga funktionsknappar:**

| Knapp | Funktion |
|---|---|
| **Byt namn** | Byt namn på den markerade filen. Kräver att en fil är markerad. |
| **Ladda ned** | Laddar ned den markerade filen till din dator. Kräver att en fil är markerad. |
| **Ta bort** | Tar bort den markerade filen. Kräver att en fil är markerad. |
| **Ny mapp** | Skapar en ny mapp. Kräver att du befinner dig i en lämplig mapp. |
| **Ladda upp** | Laddar upp en fil till aktuell mapp. |
| **Sortera efter** | Välj hur filerna ska sorteras. Öppnar en rullgardinsmeny. |
| **Rutnät / Lista** | Växla mellan rutnäts- och listvy. |

---

*Dokumentationen är baserad på Matrix42:s officiella användarguider för FastViewer Webconsole.*
