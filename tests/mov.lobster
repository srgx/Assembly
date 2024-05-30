
import gl
import color

let rSize = 64

enum dispmode:
  data_mode
  updated_mode

class Register:

  contents: [int]
  updated: [color]

  def resetUpdated():
    var i = 0
    while i < length(updated):
      updated[i] = color_black
      i += 1

constructor Register():
  let upd = []
  for(rSize): push(upd, color_black)
  return Register { contents: zeros(rSize),
                    updated: upd }

struct Vregister:

  name: string
  mregister: Register
  size: int

  def update():
    let lm = rSize - size
    var i = size - 1
    while i >= lm:
      mregister.updated[i] = color_green
      i -= 1

class Computer:

  registers: [Register]
  displayMode = data_mode
  vRegisters: [Vregister]

  def get(name: string):
    let r = getr(name)
    return slice(r.mregister.contents, rSize - r.size, r.size)

  def getr(name: string):
    for(vRegisters) r:
      if (name == r.name): return r
    return vRegisters[0]

  def resetUpdated():
    for (registers) r: r.resetUpdated()

  def mov(dest: string, n: int):
    let vreg = getr(dest)
    let mreg = vreg.mregister
    mreg.contents =
      append(slice(mreg.contents, 0, rSize - vreg.size),
             addZeros(vreg.size, toBin(n)))
    resetUpdated()
    vreg.update()

  def main():

    mov("rax", 255)
    mov("rbx", 69)

    let scalef = 20.0

    fatal(gl.window("Mov", 640, 480))

    while gl.frame() and gl.button("escape") != 1:
      if gl.button("d"):
        displayMode = data_mode
      elif gl.button("u"):
        displayMode = updated_mode
      gl.clear(color_white)
      gl.translate(float2{5., 5.})
      gl.scale(gl.window_size().y / scalef)
      for (4) i:
        for (rSize) j:
          switch displayMode:
            case data_mode:
              if registers[i].contents[j] == 1:
                gl.color(color_red)
              else:
                gl.color(color_black)
            case updated_mode: gl.color(registers[i].updated[j])
          gl.translate(float2{j * 0.5,i * 0.5}):
            gl.rect(float2{.4,.4})

constructor Computer():

  let regs = []
  let nRegisters, nVregisters = 4, 4
  for(nRegisters): push(regs, Register())

  let names = [ ["rax", "eax", "ax", "al"],
                ["rbx", "ebx", "bx", "bl"],
                ["rcx", "ecx", "cx", "cl"],
                ["rdx", "edx", "dx", "dl"] ]
  let vRegs = []
  for(nRegisters) i:
    var size = length(regs[0].contents)
    for(nVregisters) j:
      push(vRegs, Vregister { name: names[i][j],
                              mregister: regs[i],
                              size: size })
      size /= 2

  return Computer{ registers: regs, vRegisters: vRegs }

def toBin(n: int):
  var vec = []
  while 0 != n:
    vec = append([n % 2], vec)
    n /= 2
  return vec

def toDec(vec: [int]):
  var i = length(vec) - 1
  var sum, cr = 0, 1
  while i >= 0:
    sum += vec[i] * cr
    cr *= 2
    i -= 1
  return sum

def repeat(n: int, t: int):
  let vec = []
  for(t): push(vec, n)
  return vec

def zeros(n: int): return repeat(0, n)
def ones(n: int): return repeat(1, n)
def addZeros(size: int, vec: [int]):
  return append(zeros(size - length(vec)), vec)

let c = Computer()

def get(s: string): return c.get(s)
def mov(s: string, n: int): return c.mov(s, n)
def main(): c.main()

def test():
  let n = 20
  let eOnes, twenty = ones(8), toBin(n)
  let tSize = length(twenty)
  mov("rax", 255)
  mov("rcx", 20)
  assert 8 == length(get("al")) and 16 == length(get("ax")) and
         32 == length(get("eax")) and rSize == length(get("rax")) and
         equal(toBin(5),[1, 0, 1]) and toDec([1, 0, 1]) == 5 and
         equal(get("rax"), append(zeros(rSize - 8), eOnes)) and
         equal(get("eax"), append(zeros(32 - 8), eOnes)) and
         equal(get("ax"), append(zeros(16 - 8), eOnes)) and
         equal(get("al"), eOnes) and equal(get("rbx"), zeros(rSize)) and
         equal(get("rcx"), append(zeros(rSize - 5), twenty)) and
         equal(get("ecx"), append(zeros(32 - tSize), twenty)) and
         equal(get("cx"), append(zeros(16 - tSize), twenty)) and
         equal(get("cl"), append(zeros(8 - tSize), twenty))

main()

