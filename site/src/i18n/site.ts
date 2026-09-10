import catalogue from './current-messages.ts'
import registry from './locales.json' with { type: 'json' }

export type Locale = {
  name: string
  domain: string
  formatLocale: string
  ogLocale: string
  manual: boolean
  contentLocale?: string
  direction?: 'ltr' | 'rtl'
  flag?: string
}
export const locales = registry as Record<string, Locale>
export const language = import.meta.env?.PUBLIC_SITE_LOCALE || 'en'
if (!locales[language]) throw new Error(`Unknown site language: ${language}`)
export const locale = locales[language]
/** The subpath deployment base, e.g. "/codeOS" ("" when served from root). */
export const base = import.meta.env.BASE_URL.replace(/\/+$/, '')
/** The absolute site root including the deployment subpath, for canonical and OG URLs. */
export const siteUrl = `${locale.domain}${base}`

/**
 * The languages in the order a list shows them: English first, since it is
 * the source, then the rest by their own name. The registry is in the order
 * the languages arrived, which reads as no order at all.
 */
const byName = new Intl.Collator('en').compare
export const sortedLocales: Array<[string, Locale]> = Object.entries(
  locales,
).sort(([a, la], [b, lb]) =>
  a === 'en' ? -1 : b === 'en' ? 1 : byName(la.name, lb.name),
)
export const contentLocale = locale.contentLocale ?? language

/** English is the source copy; each language keeps its own reviewed catalogue. */
export function t(english: string): string {
  return catalogue[english] ?? english
}

/** A team member's countries, "USA/Denmark", each translated on its own. */
export function tCountries(meta: string): string {
  return meta.split('/').map(t).join('/')
}

export function hasTranslation(code: string, path: string): boolean {
  return (
    Boolean(locales[code]) &&
    (!path.startsWith('/manual') || locales[code].manual)
  )
}

/**
 * Keep untranslated chapters on the English site, including their fragments.
 * Every outbound link passes through here, so the subpath deployment base
 * (`/codeOS/`) is applied once, idempotently, to all router paths.
 */
export function localizedHref(href: string): string {
  // Absolute or protocol-relative links pass through untouched.
  if (/^(?:[a-z][a-z0-9+.-]*:)?\/\//i.test(href) || href.startsWith('mailto:')) {
    return href
  }
  if (!locale.manual && /^\/manual(?:[/?#]|$)/.test(href)) {
    return `${locales.en.domain}${base}${href}`
  }
  if (base && href.startsWith(`${base}/`)) return href
  return `${base}${href}`
}
