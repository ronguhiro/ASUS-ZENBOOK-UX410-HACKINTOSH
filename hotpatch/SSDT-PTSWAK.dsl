// Overriding _PTS and _WAK

DefinitionBlock("SSDT-PTSWAK", "SSDT", 2, "hack", "ptswak", 0)
{
    External(ZPTS, MethodObj)
    External(ZWAK, MethodObj)

    External(_SB.PCI0.RP01.PEGP._ON, MethodObj)
    External(_SB.PCI0.RP01.PEGP._OFF, MethodObj)

    External(RMCF.SHUT, IntObj)
    External(RMCF.XPEE, IntObj)
    External(RMCF.SSTF, IntObj)

    // In DSDT, native _PTS and _WAK are renamed ZPTS/ZWAK
    // As a result, calls to these methods land here.
    Method(_PTS, 1)
    {
        if (5 == Arg0)
        {
            // Shutdown fix, if enabled
            If (CondRefOf(\RMCF.SHUT)) { If (\RMCF.SHUT) { Return } }
        }
        
        // enable discrete graphics
        If (CondRefOf(\_SB.PCI0.RP01.PEGP._ON)) { \_SB.PCI0.RP01.PEGP._ON() }

        // call into original _PTS method
        If (LNotEqual(Arg0,5)) { ZPTS(Arg0) }

        If (5 == Arg0)
        {
            // XHC.PMEE fix, if enabled
            External(\_SB.PCI0.XHC.PMEE, FieldUnitObj)
            If (CondRefOf(\RMCF.XPEE)) { If (\RMCF.XPEE && CondRefOf(\_SB.PCI0.XHC.PMEE)) { \_SB.PCI0.XHC.PMEE = 0 } }
        }
    }
    Method(_WAK, 1)
    {
        // Take care of bug regarding Arg0 in certain versions of OS X...
        // (starting at 10.8.5, confirmed fixed 10.10.2)
        If (Arg0 < 1 || Arg0 > 5) { Arg0 = 3 }

        // call into original _WAK method
        Local0 = ZWAK(Arg0)
        
        // disable discrete graphics
        If (CondRefOf(\_SB.PCI0.RP01.PEGP._OFF)) { \_SB.PCI0.RP01.PEGP._OFF() }

        If (CondRefOf(\RMCF.SSTF))
        {
            If (\RMCF.SSTF)
            {
                // call _SI._SST to indicate system "working"
                // for more info, read ACPI specification
                External(\_SI._SST, MethodObj)
                If (3 == Arg0 && CondRefOf(\_SI._SST)) { \_SI._SST(1) }
            }
        }

        // return value from original _WAK
        Return (Local0)
    }
}