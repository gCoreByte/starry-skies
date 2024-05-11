## Tere tulemast

Tere tulemast oma uusimale e-poe platvormile! See on vaid tõend kontseptsiooni ehitamisest, millele on lisatud ainult hädavajalikud asjad. Praegu puuduvad mõned funktsioonid: allahindlused, kampaaniad, piltide üleslaadimine ja kohandatud domeenid. Võite olla kindel, nende kallal töötatakse!

## Alustamine

Tutvume platvormiga. Avage konto juhtpaneel, minnes valikusse `Kontohaldus > Armatuurlaud`. Esiteks looge pood. Valige oma poele nimi ja seejärel sobiv alamdomeen. Näiteks poodi alamdomeeniga `my-cool-store` pääseb ligi aadressilt `my-cool-store.corebyte.ee`. Asjade lihtsustamiseks on võimalik luua suvanditesse näidispood.

## Poe ülevaade

Poe ülevaate avamiseks klõpsake oma värskelt loodud poe kõrval olevat sinist silma või klõpsake selle nimel.
Poe ülevaatelehel on võimalik hallata oma uue poe kõiki aspekte, alates toodetest kuni veebilehtedeni. Samuti annab see kiire ülevaate tehtud müügist ja teenitud tulust.

### Tähelepanu

Paljud elemendid nõuavad võtme loomist. Võti on ainulaadne inimloetav väärtus, mis muudab dokumentide tuvastamise lihtsamaks. Võtmed on alati ainulaadsed, samas kui nimed mitte.

### Kategooriad

Alustuseks loome mõned kategooriad. Need võivad olla kasulikud, et aidata klientidel teie erinevaid üksusi sortida. Klõpsake nuppu `Kategooriad` ja vajutage rohelist nuppu +. See võimaldab teil luua oma kategooria. Neid kategooriaid saab hiljem tooteversioonidele lisada.

### Tooted

Järgmisena loome mõned tooted. Toodetel on versioonid, mis võimaldab jälgida sama toote varasemaid versioone, nt. erinevad kirjeldused, mõõtmed ja nii edasi.
Looge toode, klõpsates rohelist nuppu + ja seejärel lisades võti. Avage vastloodud toode, et näha selle andmeid ja luua toote versioon.

### Toote versioonid

Toote versioonid sisaldavad kogu teavet toote ühe versiooni kohta. See hõlmab nende nimede ja kirjelduste, mõõtmete ja mitmesuguste muude atribuutide tõlkeid. Kõik need atribuudid on valikulised – te ei pea neid lisama, kui te ei soovi.
Siin saate kasutajatele lisada ka erinevaid hindu. Kui soovite, et kõik seda ostaksid, peaks vähemalt ühe hinna kasutajarühm olema tühi! Kasutajarühmi selgitatakse edaspidi. Siin saate lisada tootele ka kategooriaid.
Üksikasjade aknas vasakul on sinine nupp, millel on leht. Siin saate lisada toote tõlkeid.
Kui tootel on hind olemas, saab selle aktiveerida rohelisest esitusnupust. Pärast aktiveerimist lisatakse see poodi.

### Tellimused

Siin on ülevaade kõigist tehtud tellimustest. Tellimustel võib olla 5 erinevat olekut: `created`, `processing`, `in_transit`, `completed` ja `failed`.
Lühike olekute selgitus:

- `created` - Klient on esitanud tellimuse ning see ootab kinnitust.
- `processing` - Tellimus on vastu võetud ning ootab saatmist.
- `in_transit` - Tellimus on välja saadetud.
- `completed` - Tellimus on jõudnud edukalt kliendini.
- `failed` - Midagi on läinud valesti ning tellimust ei saanud lõpule viia. See võib juhtuda erinevatel põhjustel – kasutaja tühistas tellimuse, midagi oli laost otsas jne.

Praegu ei tohiks teil tellimusi olla, kuna keegi pole veel midagi ostnud.

### Kasutajakontod

Sellest vaatest leiate ülevaate kõigist teie poes loodud kontodest. Siin on võimalik erinevatele kontodele gruppe lisada. Nendel gruppidel on hiljem teie poes erinevad hinnad.

### Kasutajarühmad

Here you can create different user groups. The higher the ranking, the higher its priority is. For example, when a user has 2 different groups `loyal` with a ranking of 1 and `great` with a ranking of 2, the user will see the prices of `loyal` groups first, then prices of `great` groups if applicable and only then will they see the global price.

Siin saate luua erinevaid kasutajarühmi. Mida kõrgem on asetus, seda kõrgem on selle prioriteet. Näiteks kui kasutajal on 2 erinevat gruppi `loyal` asetusega 1 ja `great`, mille asetus on 2, näeb kasutaja kõigepealt `loyal` rühmade hindu, seejärel `great` rühmade hindu, kus võimalik ja alles siis näevad nad üldist hinda.

### Lehe mallid

See on juhendi kõige raskemini mõistetav, kuid samas kõige olulisem osa. Lehtmallide kasutamisel saate luua oma lehti. Lehemallil on võti ja `based_on` väärtus. `based_on` väärtus dikteerib, millist tüüpi kirjet leht ootab.

Lehe malli loomisel peate nüüd looma tõlked. Praegu on kolm erinevat kohalikku keelt: `en`, `et` ja `ru`. Iga tõlke jaoks on sisuks see HTML-kood, mis renderdatakse. Selleks, et muuta oma lehti dünaamiliseks, saate oma HTML-koodis kasutada Liquid muutujaid. Selleks, et näha, millised muutujad on saadaval igale `based_on` kirjele, vaadake muutujate dokumentatsioonilehte.

#### Liquid muutujad

Liquid muutujaid saab ligi võtta kasutades `{{ record.variable }}`. Genereerimisel asendatakse need väärtustega. Liquidi saab kasutada ka keerukamate toimingute jaoks, nagu tsüklid ja tingimused. Täieliku Liquid dokumentatsiooni jaoks vaadake nende ametlikku dokumentatsiooni aadressil <https://github.com/Shopify/liquid/wiki/Liquid-for-Designers>.

Kui olete loonud lehe malli, veenduge, et aktiveerite selle rohelisest esitusnupust. See tagab, et saate seda malli oma lehtedel kasutada.

### Lehed

Siin saate luua oma veebilehe. Andke sellele võti, et seda tuvastada, unikaalne URL ja valige kasutatav lehe mall. Lehele ei pääse ligi enne, kui te seda rohelise esitusnupu abil avalikuks ei tee.

Leht on ligipääsetav järgmisel URL-il: `/p/<lehe_url>/<kirje_id>`, kus `lehe_url` on lehe jaoks valitud URL ja `kirje_id` on kirje ID, mis on sama tüüpi kui malli `based_on`. On oluline märkida, et lehe mallidel, mille `based_on` väärtus on `store`, `purchase_cart` või `user_account`, pole vaja `kirje_id` - nendele saab ligi ainult `/p/<lehe_url>`.

Kohalikud keeled määratakse küpsisega - `locale`. See küpsis vaikeväärtusega `en`, kuid seda saab seada `et` või `ru`-ks, et kasutada teisi keeli.

### API Kasutus

API selles kontekstis on veebi-URL, millele pääseb ligi mingisuguse tegevuse sooritamiseks. Veebibrauserist pääsetakse nendele peaaegu alati juurde Javascripti abil. Ärge muretsege! Neid on väga lihtne kasutada ja allpool on toodud ka näide.

Mõned poe osad nõuavad API kasutamist, näiteks esemete lisamine ja eemaldamine kasutaja ostukorvist. Neile saab juurde pääseda Javascripti kasutades. Allpool on toodud näidishoova nupp.

Hetkel on saadaval ainult 2 API lõpp-punkti:

- `purchase_carts/add_item`
- `purchase_carts/remove_item`
Mõlemad kasutavad PATCH HTTP meetodit ja võtavad sisendi järgmises JSON-vormingus:

```json
item: {
 key: 'toote_võti',
 quantity: kogus
}
```

Näiteks, et luua nupp, mis lisab toote ostukorvi, võiksite toote-põhisel lehel kasutada järgmist koodi:

```javascript
// Nupp, mida kasutaja näeb
<button id="addItem">Lisa toode</button>
<script>
 // Leia nupp id järgi (addItem) ja tee midagi, kui sellele vajutatakse
 document.getElementById('addItem').addEventListener('click', function() {

  // API URL
  var url = '/purchase_carts/add_item';
  // Andmed
  var data = {
   item: {
    key: '{{ product.key }}', // toote võti
    quantity: 1
   }
  };
  var options = {
   method: 'PATCH',
   headers: {
    'Content-Type': 'application/json',
   },
   body: JSON.stringify(data),
  };
  // Saada päring
  fetch(url, options).then(response => {
   if (response.ok) {
    // lae leht uuesti et uuendada andmeid
    window.location.reload();
   } else {
    console.error('PATCH request failed');
    // Serveripoolne viga, nt toodet ei leitud
   }
  }).catch(error => {
   console.error('Error during PATCH request:', error);
   // Midagi läks päringu saatmisel valesti, nt vigased parameetrid
  });
 });
</script>
```

### Completing a purchase order

To finalise a purchase, redirect the user to `/purchase_orders/new`. On this page, they will be able to complete their purchases as well as pay in the future. It will be possible to edit this page in the future.

### Creating accounts and logging in

To create a user account, the user must go to `/user_accounts/new`, where they can register. To log in, the user must go to `/user_sessions/new`. To log out, send a HTTP delete request to `/user_sessions/`.

### Tellimuse lõpuleviimine

Tellimuse lõpuleviimiseks suunake kasutaja aadressile `/purchase_orders/new`. Selles lehel saavad nad oma ostud lõpule viia ja tulevikus maksta. Seda lehte on tulevikus võimalik muuta.

### Kasutajakontode loomine ja sisse logimine

Kasutajakonto loomiseks peab kasutaja minema aadressile `/user_accounts/new`, kus saavad nad registreeruda. Sisse logimiseks peab kasutaja minema aadressile `/user_sessions/new`. Välja logimiseks saada HTTP DELETE päring aadressile `/user_sessions/`.
