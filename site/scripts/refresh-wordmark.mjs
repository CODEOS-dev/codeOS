/**
 * Regenerate src/data/wordmark-bitmap.ts from public/brand/codeOS-wordmark.svg.
 *
 * The wordmark is a grid of 51x50 unit cells: 81 across, 19 down. Every rect
 * in the SVG lands exactly on that grid, so the bitmap is just the occupancy
 * of those cells. The hero draws the same cells on its own field grid, which
 * is why the two can never fall out of alignment.
 *
 * Run: node scripts/refresh-wordmark.mjs
 */
import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..')

const svg = fs.readFileSync(
  path.join(root, 'public/brand/codeOS-wordmark.svg'),
  'utf8',
)

const CW = 51
const CH = 50

const rects = [...svg.matchAll(/<rect x="(\d+)" y="(\d+)" width="(\d+)" height="(\d+)"\/>/g)]
  .map((m) => ({
    x: Number(m[1]),
    y: Number(m[2]),
    w: Number(m[3]),
    h: Number(m[4]),
  }))
  .filter((r) => r.w === CW && r.h === CH)

if (rects.length === 0) throw new Error('no 51x50 cell rects found in the wordmark svg')

const maxX = Math.max(...rects.map((r) => r.x + r.w))
const maxY = Math.max(...rects.map((r) => r.y + r.h))
const W = maxX / CW
const H = maxY / CH

const grid = Array.from({ length: H }, () => Array(W).fill('0'))
for (const r of rects) {
  const col = r.x / CW
  const row = r.y / CH
  grid[row][col] = '1'
}

const rows = grid.map((r) => r.join(''))
const total = rects.length

fs.writeFileSync(
  path.join(root, 'src/data/wordmark-bitmap.ts'),
  `/**
 * The codeOS wordmark as what it actually is: a ${W}x${H} bitmap. Generated
 * from the site's brand/codeOS-wordmark.svg, whose ${total} rects all land
 * exactly on a ${CW}x${CH} unit grid. The hero draws these cells on the same
 * grid as the background field, so logo and field can never fall out of
 * alignment.
 *
 * Regenerate with: npm run refresh-wordmark
 */
export const WORDMARK_WIDTH = ${W}
export const WORDMARK_HEIGHT = ${H}

export const WORDMARK_ROWS = [
${rows.map((r) => `  '${r}',`).join('\n')}
]
`,
)

console.log(`${W} x ${H} cells, ${total} rects`)
for (const r of rows)
  console.log('  ' + [...r].map((c) => (c === '1' ? '#' : '.')).join(''))
