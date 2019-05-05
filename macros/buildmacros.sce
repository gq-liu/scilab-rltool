// Copyright (C) 2012 - Michael Baudin
// Copyright (C) 2008-2009 - INRIA - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

//

function buildMacros()
        macros_path = get_absolute_file_path("buildmacros.sce");
        tbx_build_macros(TOOLBOX_NAME, macros_path);

endfunction

buildMacros();
clear buildMacros;