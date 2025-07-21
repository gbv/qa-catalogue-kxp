import fs from "fs"
import { serializePica } from "pica-data"

const avram = JSON.parse(fs.readFileSync(process.stdin.fd))

const subfields = field => {
  const sf = []
  for (const { code, label, repeatable } of Object.values(field.subfields)) {
    sf.push(code, label || '?')
    if (repeatable) sf.push(code, `${label || '?'} 2`)
  }
  return sf
}

const pica = []
for (let field of Object.values(avram.fields)) {
  var { tag, repeatable, occurrence } = field

  var occ = occurrence ? occurrence.replace(/-.*/,'') : ''
  if (occ == "00") occ = ""
  const picafield = [ tag, occ || '' ]
  if (tag == "003@") {
    picafield.push('0', "12345") // PPN must look like this
  } else {
    picafield.push(...subfields(field))
  }
  pica.push(picafield)

  if (repeatable) {
    pica.push(picafield)
  } else if (occurrence?.match("-")) {
    occ = occurrence.split("-")[1]
    pica.push([tag, occ, ...subfields(field)])
  }
}

console.log(serializePica(pica))
