import { render } from '@testing-library/preact'
import { describe, expect, test } from 'vitest'
import { Header } from '../src'

describe('Header', () => {
  test('text change', async () => {
    const { queryByText } = render(<Header />)
    const headerTxt = await queryByText('Header')
    expect(headerTxt).toBeTruthy()
    expect(headerTxt).toBe('Header')
  })
})
