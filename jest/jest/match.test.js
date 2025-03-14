test('equal', () => {
    expect(2 + 2).toBe(4);
})
test('fullequal', () => {
    const dt = { one: '1', two: '2' };
    expect(dt).toEqual({ one: '1', two: '2' });
})
test(`boolean`, () => {
    const n = null;
    expect(n).toBeNull();
})
test(`not`,()=>{
    const n=1;
    expect(n).not.toEqual(0);
})
test(`number`,()=>{
    const value=2+2;
    const fl=0.1+0.2;
    expect(value).toBeGreaterThan(3);
    expect(value).toBeLessThan(5);
    expect(fl).toBeCloseTo(0.3);
    
})
test(`string`,()=>{
    const str="abcdfeghijklmn"
    expect(str).toMatch(/feg/);
})
test(`array`,()=>{
    const arr=['1','2','3','4','6'];
    expect(arr).toContain("1");
    expect(arr).not.toContain("5");
})